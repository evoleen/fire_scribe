import 'package:fire_scribe/auth/providers/auth_provider.dart';

class BearerTokenAuthProvider extends AuthProvider {
  final String bearerToken;

  BearerTokenAuthProvider({
    required this.bearerToken,
  });

  @override
  Future<String?> accessToken() async {
    return bearerToken;
  }
}
