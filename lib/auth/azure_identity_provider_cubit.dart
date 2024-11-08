import 'package:auth_cubit/auth_cubit.dart';
import 'package:azure_identity/azure_identity.dart';
import 'package:fire_scribe/app_logger.dart';

class AzureIdentityProviderCubitParams extends AuthProviderCubitParams {
  final String serverUrl;

  AzureIdentityProviderCubitParams({
    required this.serverUrl,
  });
}

class AzureIdentityProviderCubit
    extends AuthProviderCubit<AzureIdentityProviderCubitParams> {
  final DefaultAzureCredential defaultAzureCredential;

  CredentialManager? _credentialManager;

  AzureIdentityProviderCubit({required this.defaultAzureCredential})
      : super(const AuthProviderState.unauthenticated());

  @override
  Future<bool> signIn([AzureIdentityProviderCubitParams? params]) async {
    if (params == null) {
      return false;
    }
    _credentialManager = CredentialManager(
      credential: defaultAzureCredential,
      options: GetTokenOptions(
        scopes: [
          params.serverUrl,
        ],
      ),
    );

    try {
      final token = await _credentialManager!.getAccessToken();
      if (token?.token != null) {
        emit(AuthProviderState.authenticated());
      }
      return token?.token != null;
    } catch (e) {
      AppLogger.instance.e(e);
      return false;
    }
  }

  @override
  Future<bool> signIn2FA([AuthProviderCubitParams? params]) async {
    return false;
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
    if (token?.token == null) {
      emit(AuthProviderState.unauthenticated());
    }
    return token?.token;
  }
}
