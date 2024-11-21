import 'package:azure_identity/azure_identity.dart';
import 'package:fire_scribe/auth/providers/token_provider.dart';

/// This auth provider is designed to authenticate into Azure Health Data Service
/// In is authenticated state, will offer the URL of the server in form of a [String]
class AzureIdentityTokenProviderDesktop extends TokenProvider {
  final CredentialManager credentialManager;

  AzureIdentityTokenProviderDesktop({
    required final TokenCredential tokenCredential,
    required final String url,
  }) : credentialManager = CredentialManager(
          credential: tokenCredential,
          options: GetTokenOptions(
            scopes: [
              url,
            ],
          ),
        );

  @override
  Future<String?> accessToken() async {
    final token = await credentialManager.getAccessToken();
    return token?.token;
  }
}
