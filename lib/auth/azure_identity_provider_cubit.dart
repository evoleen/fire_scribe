import 'package:auth_cubit/auth_cubit.dart';
import 'package:azure_identity/azure_identity.dart';
import 'package:firearrow_admin_app/app_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AzureIdentityProviderCubitParams extends AuthProviderCubitParams {
  final String serverUrl;

  AzureIdentityProviderCubitParams({
    required this.serverUrl,
  });
}

/// This auth provider is designed to authenticate into Azure Health Data Service
/// In is authenticated state, will offer a [AzureHealthDataServiceConnection] for
/// having the connection configuration to interact with the data
class AzureIdentityProviderCubit
    extends AuthProviderCubit<AzureIdentityProviderCubitParams> {
  final DefaultAzureCredential defaultAzureCredential;
  final Talker talker;

  CredentialManager? _credentialManager;

  AzureIdentityProviderCubit({
    required this.defaultAzureCredential,
    required this.talker,
  }) : super(const AuthProviderState.unauthenticated());

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
