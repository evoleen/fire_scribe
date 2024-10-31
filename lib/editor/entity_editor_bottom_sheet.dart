import 'dart:convert';

import 'package:firearrow_admin_app/editor/entity_editor_cubit.dart';
import 'package:firearrow_admin_app/editor/patient_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_editor_flutter/json_editor_flutter.dart';

class EntityEditorBottonSheet extends StatefulWidget {
  const EntityEditorBottonSheet({
    super.key,
    required this.entityDataJson,
  });

  static const maxHeightRatio = 0.8;
  static const minHeightRatio = 0.5;
  final String entityDataJson;

  static Future<dynamic> show(
    final BuildContext context, {
    required final String entityDataJson,
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
            sourceDataJson: entityDataJson,
          ),
          child: EntityEditorBottonSheet(
            entityDataJson: entityDataJson,
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
                  sourceDataJson: widget.entityDataJson,
                ),
              ),
              Expanded(
                child: JsonEditor(
                  json: jsonEncode(patientJson),
                  onChanged: (data) =>
                      BlocProvider.of<EntityEditorCubit>(context).update(
                    entityDataJson: jsonEncode(data),
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
    required this.sourceDataJson,
  });

  final String sourceDataJson;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntityEditorCubit, EntityEditorCubitState>(
      builder: (context, state) {
        final wasModified = state.maybeWhen(
          data: (data) => data != sourceDataJson,
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
                      'KDSIW32982JKDSDSD',
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
                      'Save Changes',
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
