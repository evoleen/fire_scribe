import 'package:auth_cubit/auth_cubit.dart';
import 'package:azure_identity_provider/src/azure_identity_provider_cubit_params.dart';

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
    throw Exception('Provider cannot be usable on web');
  }

  @override
  Future<bool> signOut() async {
    throw Exception('Provider cannot be usable on web');
  }

  @override
  Future<String?> accessToken() async {
    throw Exception('Provider cannot be usable on web');
  }
}
