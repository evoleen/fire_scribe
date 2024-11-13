import 'package:fire_scribe/auth/providers/azure_identity/azure_identity_provider_cubit_base.dart';

AzureIdentityProviderCubit createAzureIdentityProviderCubit() {
  return AzureIdentityProviderCubitWeb();
}

class AzureIdentityProviderCubitWeb extends AzureIdentityProviderCubit {
  /// We need to identify as base class in order to make the interface
  /// usable on web and desktop
  @override
  Type get runtimeType => AzureIdentityProviderCubit;
}
