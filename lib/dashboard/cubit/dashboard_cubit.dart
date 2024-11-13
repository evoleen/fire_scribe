import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_cubit.freezed.dart';

@freezed
class DashboardCubitState with _$DashboardCubitState {
  const factory DashboardCubitState.noselected() = _NoSelected;
  const factory DashboardCubitState.selected(
      {required final String entityType}) = _Selected;
}

class DashboardCubit extends Cubit<DashboardCubitState> {
  DashboardCubit() : super(DashboardCubitState.noselected());

  void select({required final String entityType}) {
    emit(DashboardCubitState.selected(entityType: entityType));
  }

  void unselect() {
    emit(DashboardCubitState.noselected());
  }
}
