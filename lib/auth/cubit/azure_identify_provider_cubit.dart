import 'package:auth_cubit/auth_cubit.dart';
import 'package:azure_identity/azure_identity.dart';
import 'package:firearrow_admin_app/app_logger.dart';

class AzureIdentifyProviderCubitParams extends AuthProviderCubitParams {
  final String serverUrl;

  AzureIdentifyProviderCubitParams({
    required this.serverUrl,
  });
}

class AzureIdentifyProviderCubit
    extends AuthProviderCubit<AzureIdentifyProviderCubitParams> {
  final DefaultAzureCredential defaultAzureCredential;

  CredentialManager? _credentialManager;

  AzureIdentifyProviderCubit({required this.defaultAzureCredential})
      : super(const AuthProviderState.unauthenticated());

  @override
  Future<bool> signIn([AzureIdentifyProviderCubitParams? params]) async {
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
      return token?.token != null;
    } catch (e) {
      AppLogger.instance.e(e);
      return false;
    }
  }

  @override
  Future<bool> signIn2FA([AzureIdentifyProviderCubitParams? params]) async {
    return false;
  }

  @override
  Future<bool> signOut() async {
    _credentialManager = null;
    return true;
  }

  @override
  Future<String?> accessToken() async {
    final token = await _credentialManager?.getAccessToken();
    return token?.token;
  }
}
