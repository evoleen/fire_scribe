//

import 'package:azure_identity/azure_identity.dart';
import 'package:fire_scribe/app_logger.dart';
import 'package:fire_scribe/auth/auth_cubit/auth_provider_cubit.dart';
import 'package:fire_scribe/auth/providers/azure_identity/azure_identity_provider_cubit_base.dart';

AzureIdentityProviderCubit getAzureIdentityProviderCubit() {
  return AzureIdentityProviderCubitDesktop(
    azureCredential: DefaultAzureCredential(
      logger: AppLogger.instance.d,
    ),
  );
}

/// This auth provider is designed to authenticate into Azure Health Data Service
/// In is authenticated state, will offer the URL of the server in form of a [String]
class AzureIdentityProviderCubitDesktop extends AzureIdentityProviderCubit {
  final DefaultAzureCredential azureCredential;

  CredentialManager? _credentialManager;

  AzureIdentityProviderCubitDesktop({
    required this.azureCredential,
  });

  @override
  Future<bool> signIn([AzureIdentityProviderCubitParams? params]) async {
    if (params == null) {
      return false;
    }
    _credentialManager = CredentialManager(
      credential: azureCredential,
      options: GetTokenOptions(
        scopes: [
          params.serverUrl,
        ],
      ),
    );

    try {
      final isSigned = await accessToken() != null;
      if (!isSigned) {
        emit(AuthProviderState.unauthenticated());
        return false;
      }
      emit(AuthProviderState.authenticated(data: params.serverUrl));
      return true;
    } catch (e) {
      AppLogger.instance.e(e);
      emit(AuthProviderState.unauthenticated());
      return false;
    }
  }

  @override
  Future<bool> signOut() async {
    _credentialManager = null;
    emit(AuthProviderState.unauthenticated());
    return true;
  }

  @override
  Future<String?> accessToken() async {
    final token = await _credentialManager?.getAccessToken();

    return token?.token;
  }
}
