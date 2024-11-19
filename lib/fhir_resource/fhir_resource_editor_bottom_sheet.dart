import 'package:fhir/r4.dart';
import 'package:fire_scribe/fhir_resource/fhir_json_code_editor.dart';
import 'package:fire_scribe/fhir_resource/fhir_resource_editor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FhirResourceEditorBottonSheet extends StatelessWidget {
  const FhirResourceEditorBottonSheet({
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
        builder: (context) => FhirResourceEditorBottonSheet(
          resource: resource,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 1.0,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: BlocProvider(
            create: (context) => FhirResourceEditorCubit(
              resource: resource,
            ),
            child: FhirJsonCodeEditor(
              initialResource: resource,
            ),
          ),
        );
      },
    );
  }
}
