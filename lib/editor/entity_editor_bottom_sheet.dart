import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:fire_scribe/editor/entity_editor_cubit.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:highlight/languages/json.dart';

class EntityEditorBottonSheet extends StatefulWidget {
  const EntityEditorBottonSheet({
    super.key,
    required this.resource,
  });

  static const maxHeightRatio = 0.8;
  static const minHeightRatio = 0.5;
  final Resource resource;

  static Future<dynamic> show(
    final BuildContext context, {
    required final Resource resource,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          minWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height * maxHeightRatio,
          minHeight: MediaQuery.of(context).size.height * minHeightRatio,
        ),
        backgroundColor: Colors.transparent,
        builder: (context) => BlocProvider(
          create: (context) => EntityEditorCubit(
            resource: resource,
          ),
          child: EntityEditorBottonSheet(
            resource: resource,
          ),
        ),
      );

  @override
  State createState() => _EntityEditorBottonSheetState();
}

class _EntityEditorBottonSheetState extends State<EntityEditorBottonSheet> {
  var sheetSize = 1.0;

  final minChildSize = 1.0 -
      EntityEditorBottonSheet.minHeightRatio *
          EntityEditorBottonSheet.minHeightRatio;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: sheetSize,
      minChildSize: minChildSize,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  final newSheetSize = (sheetSize -
                          details.primaryDelta! /
                              MediaQuery.of(context).size.height)
                      .clamp(minChildSize, 1.0);
                  setState(() {
                    sheetSize = newSheetSize;
                  });
                },
                child: EntityEditorDraggableHeader(
                  resource: widget.resource,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CodeTheme(
                    data: CodeThemeData(
                      styles: atomOneLightTheme,
                    ),
                    child: CodeField(
                      controller: CodeController(
                        text: JsonEncoder.withIndent('\t')
                            .convert(widget.resource.toJson()),
                        readOnlySectionNames: {
                          'resourceType',
                          'id',
                        },
                        language: json,
                      ),
                      onChanged: (data) =>
                          BlocProvider.of<EntityEditorCubit>(context).update(
                        resource: Resource.fromJsonString(data),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class EntityEditorDraggableHeader extends StatelessWidget {
  const EntityEditorDraggableHeader({
    super.key,
    required this.resource,
  });

  final Resource resource;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntityEditorCubit, EntityEditorCubitState>(
      builder: (context, state) {
        final wasModified = state.maybeWhen(
          data: (data) => data.toJsonString() != resource.toJsonString(),
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
                      resource.fhirId ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                FilledButton(
                  onPressed: wasModified
                      ? () =>
                          BlocProvider.of<EntityEditorCubit>(context).publish()
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
        );
      },
    );
  }
}
