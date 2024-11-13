import 'package:fire_scribe/auth/providers/azure_identity/azure_identity_provider_cubit_base.dart';

AzureIdentityProviderCubit getAzureIdentityProviderCubit() {
  return AzureIdentityProviderCubitWeb();
}

class AzureIdentityProviderCubitWeb extends AzureIdentityProviderCubit {}
