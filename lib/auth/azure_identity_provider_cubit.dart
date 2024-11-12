import 'package:azure_identity/azure_identity.dart';
import 'package:fire_scribe/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'azure_identity_provider_cubit.freezed.dart';

@freezed
class AzureIdentityProviderCubitState<T>
    with _$AzureIdentityProviderCubitState {
  const factory AzureIdentityProviderCubitState.unauthenticated() =
      _Unauthenticated;
  const factory AzureIdentityProviderCubitState.authenticated(
      {required final String serverUrl}) = _Authenticated;
}

/// This auth provider is designed to authenticate into Azure Health Data Service
/// In is authenticated state, will offer the URL of the server in form of a [String]
class AzureIdentityProviderCubit
    extends Cubit<AzureIdentityProviderCubitState> {
  final DefaultAzureCredential azureCredential;

  CredentialManager? _credentialManager;

  AzureIdentityProviderCubit({
    required this.azureCredential,
  }) : super(const _Unauthenticated());

  Future<bool> signIn({required final String serverUrl}) async {
    _credentialManager = CredentialManager(
      credential: azureCredential,
      options: GetTokenOptions(
        scopes: [
          serverUrl,
        ],
      ),
    );

    try {
      final isSigned = await accessToken() != null;
      if (!isSigned) {
        emit(_Unauthenticated());
        return false;
      }
      emit(_Authenticated(serverUrl: serverUrl));
      return true;
    } catch (e) {
      AppLogger.instance.e(e);
      emit(_Unauthenticated());
      return false;
    }
  }

  Future<bool> signOut() async {
    _credentialManager = null;
    emit(_Unauthenticated());
    return true;
  }

  Future<String?> accessToken() async {
    final token = await _credentialManager?.getAccessToken();

    return token?.token;
  }
}
