import 'package:fhir/r4.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entity_editor_cubit.freezed.dart';

@freezed
class EntityEditorCubitState with _$EntityEditorCubitState {
  const factory EntityEditorCubitState.busy() = _Busy;
  const factory EntityEditorCubitState.data({
    required final Resource resource,
  }) = _Data;
  const factory EntityEditorCubitState.error() = _Error;
}

class EntityEditorCubit extends Cubit<EntityEditorCubitState> {
  EntityEditorCubit({required final Resource resource})
      : super(
          EntityEditorCubitState.data(
            resource: resource,
          ),
        );

  /// Updates the local copy of [_Data] to have it available for publishing [publish]
  Future<void> update({required final Resource resource}) async {
    emit(EntityEditorCubitState.data(resource: resource));
  }

  /// Publish to cloud the current Resource that is working on
  Future<bool> publish() async {
    return false;
  }
}
