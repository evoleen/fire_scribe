//

import 'package:azure_identity/azure_identity.dart';
import 'package:fire_scribe/app_logger.dart';
import 'package:fire_scribe/auth/providers/azure_identity/azure_identity_token_provider_base.dart';

AzureIdentityTokenProvider createAzureIdentityProviderCubit() {
  return AzureIdentityTokenProviderDesktop(
    azureCredential: DefaultAzureCredential(
      logger: AppLogger.instance.d,
    ),
  );
}

/// This auth provider is designed to authenticate into Azure Health Data Service
/// In is authenticated state, will offer the URL of the server in form of a [String]
class AzureIdentityTokenProviderDesktop extends AzureIdentityTokenProvider {
  final DefaultAzureCredential azureCredential;

  AzureIdentityTokenProviderDesktop({
    required this.azureCredential,
  });

  @override
  Future<String?> accessToken() async {
    final credentialManager = CredentialManager(
      credential: azureCredential,
      options: GetTokenOptions(
        scopes: [
          '',
          // params.serverUrl,
        ],
      ),
    );

    final token = await credentialManager.getAccessToken();
    return token?.token;
  }
}
