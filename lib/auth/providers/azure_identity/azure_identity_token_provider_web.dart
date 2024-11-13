import 'package:fire_scribe/auth/providers/azure_identity/azure_identity_token_provider_base.dart';

AzureIdentityTokenProvider createAzureIdentityProvider() {
  return AzureIdentityTokenProviderWeb();
}

class AzureIdentityTokenProviderWeb extends AzureIdentityTokenProvider {
  AzureIdentityTokenProviderWeb();

  @override
  Future<String?> accessToken() async {
    return null;
  }
}
