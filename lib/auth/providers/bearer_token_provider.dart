import 'package:fire_scribe/auth/providers/token_provider.dart';

class BearerTokenAuthProvider extends TokenProvider {
  final String bearerToken;

  BearerTokenAuthProvider({
    required this.bearerToken,
  });

  @override
  Future<String?> accessToken() async {
    return bearerToken;
  }
}
