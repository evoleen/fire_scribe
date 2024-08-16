import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_azure_identify_provider_cubit.freezed.dart';
part 'auth_azure_identify_provider_state.dart';

class AuthAzureIdentifyProviderCubit
    extends Cubit<AuthAzureIdentifyProviderState> {
  AuthAzureIdentifyProviderCubit()
      : super(AuthAzureIdentifyProviderState.initial());
}
