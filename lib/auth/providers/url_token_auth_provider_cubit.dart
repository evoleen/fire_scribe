import 'package:auth_cubit/auth_cubit.dart';

class UrlTokenAuthProviderCubitParams extends AuthProviderCubitParams {
  final String serverUrl;
  final String token;

  UrlTokenAuthProviderCubitParams({
    required this.serverUrl,
    required this.token,
  });
}

/// This auth provider is designed to authenticate into Azure Health Data Service
/// In is authenticated state, will offer the URL of the server in form of a [String]
class UrlTokenAuthProviderCubit
    extends AuthProviderCubit<UrlTokenAuthProviderCubitParams> {
  UrlTokenAuthProviderCubit()
      : super(const AuthProviderState.unauthenticated());

  @override
  Future<bool> signIn([UrlTokenAuthProviderCubitParams? params]) async {
    if (params == null) {
      emit(AuthProviderState.unauthenticated());
      return false;
    }
    emit(AuthProviderState.authenticated(data: params));
    return true;
  }

  @override
  Future<bool> signOut() async {
    emit(AuthProviderState.unauthenticated());
    return true;
  }

  @override
  Future<String?> accessToken() async {
    return state.when(
        unauthenticated: () => null,
        authenticated: (data) {
          return data.token;
        });
  }
}
