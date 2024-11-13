import 'package:fire_scribe/auth/providers/auth_provider.dart';

class AzureIdentityTokenProvider extends AuthProvider {
  AzureIdentityTokenProvider();

  @override
  Future<String?> accessToken() async {
    return null;
  }
}
