import 'package:fire_scribe/auth/auth_cubit/auth_provider_cubit.dart';

class AzureIdentityProviderCubitParams extends AuthProviderCubitParams {
  final String serverUrl;

  AzureIdentityProviderCubitParams({
    required this.serverUrl,
  });
}

AzureIdentityProviderCubit getAzureIdentityProviderCubit() {
  return AzureIdentityProviderCubit();
}

/// This auth provider is designed to authenticate into Azure Health Data Service
/// In is authenticated state, will offer the URL of the server in form of a [String]
class AzureIdentityProviderCubit
    extends AuthProviderCubit<AzureIdentityProviderCubitParams> {
  AzureIdentityProviderCubit()
      : super(const AuthProviderState.unauthenticated());

  @override
  Future<bool> signIn([AzureIdentityProviderCubitParams? params]) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() async {
    throw UnimplementedError();
  }

  @override
  Future<String?> accessToken() async {
    throw UnimplementedError();
  }
}
