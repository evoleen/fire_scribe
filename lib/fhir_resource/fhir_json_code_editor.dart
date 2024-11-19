import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:fire_scribe/app_logger.dart';
import 'package:fire_scribe/fhir_resource/fhir_resource_editor_cubit.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:highlight/languages/json.dart';

class FhirJsonCodeEditor extends StatefulWidget {
  const FhirJsonCodeEditor({
    super.key,
    required this.initialResource,
  });

  final Resource initialResource;

  @override
  State<FhirJsonCodeEditor> createState() => _FhirJsonCodeEditorState();
}

class _FhirJsonCodeEditorState extends State<FhirJsonCodeEditor> {
  String? currentFormatError;
  late CodeController codeController;

  @override
  void initState() {
    super.initState();

    codeController = CodeController(
      analyzer: DefaultLocalAnalyzer(),
      text: JsonEncoder.withIndent('\t').convert(
        widget.initialResource.toJson()
          ..remove('id')
          ..remove('resourceType'),
      ),
      params: EditorParams(
        tabSpaces: 4,
      ),
      language: json,
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  String? getLineBeforeError(final FormatException formatException) {
    if (formatException.offset == null) {
      return null;
    }

    final lines = formatException.source.split('\n') as List<String>;
    var currentOffset = 0;
    var errorLine = 0;

    for (int i = 0; i < lines.length; i++) {
      currentOffset += lines[i].length + 1;
      if (currentOffset > formatException.offset!) {
        errorLine = i;
        break;
      }
    }

    return errorLine > 0 ? lines[errorLine - 1] : null;
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Column(
        children: [
          BlocBuilder<FhirResourceEditorCubit, FhirResourceEditorCubitState>(
            builder: (context, state) {
              final wasModified = state.maybeWhen(
                data: (data) =>
                    data.toJsonString() !=
                    widget.initialResource.toJsonString(),
                orElse: () => false,
              );

              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(Icons.close),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${widget.initialResource.resourceType?.name}/${widget.initialResource.fhirId}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      FilledButton(
                        onPressed: wasModified && currentFormatError == null
                            ? () => BlocProvider.of<FhirResourceEditorCubit>(
                                    context)
                                .publish()
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 10,
                          ),
                          child: Text(
                            S.of(context).saveChanges,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: CodeTheme(
              data: CodeThemeData(
                styles: atomOneLightTheme,
              ),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: CodeField(
                  controller: codeController,
                  onChanged: (data) {
                    try {
                      final decodedJson = jsonDecode(data);

                      BlocProvider.of<FhirResourceEditorCubit>(context).update(
                        resource: Resource.fromJson(decodedJson
                          ..['id'] = widget.initialResource.fhirId!
                          ..['resourceType'] =
                              widget.initialResource.resourceType!.name),
                      );
                      setState(() {
                        currentFormatError = null;
                      });
                    } on FormatException catch (e, st) {
                      final error = getLineBeforeError(e)?.trim();
                      setState(() {
                        currentFormatError = 'Invalid JSON Format: $error';
                      });
                      AppLogger.instance.e(e, st);
                    } catch (e, st) {
                      setState(() {
                        currentFormatError = 'Invalid FHIR JSON Format';
                      });
                      AppLogger.instance.e(e, st);
                    }
                  },
                ),
              ),
            ),
          ),
          if (currentFormatError != null)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xfffdeded),
                border: Border.all(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                child: Text(currentFormatError!),
              ),
            )
        ],
      ),
    );
  }
}
