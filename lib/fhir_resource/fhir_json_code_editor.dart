import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:fire_scribe/app_logger.dart';
import 'package:fire_scribe/auth/cubit/fhir_server_connection_cubit.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:fire_scribe/widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:highlight/languages/json.dart';

class FhirJsonCodeEditor extends StatefulWidget {
  const FhirJsonCodeEditor({
    super.key,
    required this.resource,
  });

  final Resource resource;

  @override
  State<FhirJsonCodeEditor> createState() => _FhirJsonCodeEditorState();
}

class _FhirJsonCodeEditorState extends State<FhirJsonCodeEditor> {
  String? currentFormatError;
  bool wasModified = false;
  late CodeController codeController;

  @override
  void initState() {
    super.initState();

    codeController = CodeController(
      analyzer: DefaultLocalAnalyzer(),
      text: JsonEncoder.withIndent('\t').convert(
        widget.resource.toJson(),
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
    final formatExceptionOffset = formatException.offset;
    if (formatExceptionOffset == null) {
      return null;
    }

    final lines = formatException.source.split('\n') as List<String>;
    var currentOffset = 0;
    var errorLine = 0;

    for (var i = 0; i < lines.length; i++) {
      currentOffset += lines[i].length + 1;
      if (currentOffset > formatExceptionOffset) {
        errorLine = i;
        break;
      }
    }

    return errorLine > 0 ? lines[errorLine - 1] : null;
  }

  Future<void> updateLocalCopy(final String data) async {
    try {
      // Try to decode as JSON in order to detect syntax errors
      final decodedJson = jsonDecode(data);
      // Try to decode as FHIR JSON in order to detect syntax errors
      final resource = Resource.fromJson(decodedJson);

      setState(() {
        currentFormatError = null;
        wasModified = widget.resource != resource;
      });
    } on FormatException catch (e, st) {
      final error = getLineBeforeError(e)?.trim();
      setState(() {
        currentFormatError = S.of(context).invalidJsonFormat(error ?? '');
      });
      AppLogger.instance.e(e, st);
    } catch (e, st) {
      setState(() {
        currentFormatError = S.of(context).invalidFhirJsonFormat;
      });
      AppLogger.instance.e(e, st);
    }
  }

  Future<void> publish() async {
    try {
      // Try to decode as JSON in order to detect syntax errors
      final decodedJson =
          jsonDecode(codeController.fullText) as Map<String, dynamic>;
      // Try to decode as FHIR JSON in order to detect syntax errors
      final resource = Resource.fromJson(decodedJson);
      final resourceName = resource.resourceType?.name;
      final resourceId = resource.fhirId;

      if (resourceId == null || resourceName == null) {
        setState(() {
          currentFormatError = S.of(context).invalidFhirJsonFormat;
        });
        return;
      }

      var continueWithWarnings = true;
      if (widget.resource.fhirId != resource.fhirId) {
        continueWithWarnings = await WarningDialog.show(
              context,
              warningMessage: S.of(context).warningResourceIdChanged,
            ) ??
            false;
      } else if (widget.resource.resourceType?.name !=
          resource.resourceType?.name) {
        continueWithWarnings = await WarningDialog.show(
              context,
              warningMessage: S.of(context).warningResourceTypeChanged,
            ) ??
            false;
      }

      if (!continueWithWarnings) {
        return;
      }

      final rawBundle =
          await BlocProvider.of<FhirServerConnectionCubit>(context).request(
        request: FhirRequest(
            operation: FhirRequestOperation.update,
            entityName: resourceName,
            entityId: resourceId,
            parameters: decodedJson),
      );

      if (rawBundle == null) {
        setState(() {
          currentFormatError = S.of(context).errorWhenUpdatingResource;
        });
        return;
      }
      setState(() {
        currentFormatError = null;
        wasModified = false;
      });

      final updatedResource = Resource.fromJson(rawBundle);
      Navigator.of(context).pop(updatedResource);
    } on FormatException catch (e, st) {
      final error = getLineBeforeError(e)?.trim();
      setState(() {
        currentFormatError = S.of(context).invalidJsonFormat(error ?? '');
      });
      AppLogger.instance.e(e, st);
    } catch (e, st) {
      setState(() {
        currentFormatError = S.of(context).invalidFhirJsonFormat;
      });
      AppLogger.instance.e(e, st);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Column(
        children: [
          Container(
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
                        '${widget.resource.resourceType?.name}/${widget.resource.fhirId}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  FilledButton(
                    onPressed: wasModified && currentFormatError == null
                        ? () => publish()
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      child: Text(
                        S.of(context).saveChanges,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  onChanged: (data) => updateLocalCopy(data),
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
