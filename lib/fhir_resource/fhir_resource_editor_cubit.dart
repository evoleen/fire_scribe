import 'package:fhir/r4.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fhir_resource_editor_cubit.freezed.dart';

@freezed
class FhirResourceEditorCubitState with _$FhirResourceEditorCubitState {
  const factory FhirResourceEditorCubitState.busy() = _Busy;
  const factory FhirResourceEditorCubitState.data({
    required final Resource resource,
  }) = _Data;
  const factory FhirResourceEditorCubitState.error() = _Error;
}

class FhirResourceEditorCubit extends Cubit<FhirResourceEditorCubitState> {
  FhirResourceEditorCubit({required final Resource resource})
      : super(
          FhirResourceEditorCubitState.data(
            resource: resource,
          ),
        );

  /// Updates the local copy of [_Data] to have it available for publishing [publish]
  Future<void> update({required final Resource resource}) async {
    emit(FhirResourceEditorCubitState.data(resource: resource));
  }

  /// Publish to cloud the current Resource that is working on
  Future<bool> publish() async {
    return false;
  }
}
