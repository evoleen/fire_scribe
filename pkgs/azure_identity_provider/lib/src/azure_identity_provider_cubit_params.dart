import 'package:auth_cubit/auth_cubit.dart';

class AzureIdentityProviderCubitParams extends AuthProviderCubitParams {
  final String serverUrl;

  AzureIdentityProviderCubitParams({
    required this.serverUrl,
  });
}
