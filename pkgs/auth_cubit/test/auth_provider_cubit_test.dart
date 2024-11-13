import 'package:auth_cubit/auth_cubit.dart';
import 'package:auth_cubit/src/auth_provider_cubit.dart';
import 'package:test/test.dart';

class EmailAuthProviderCubit
    extends AuthProviderCubit<AuthProviderCubitParams> {
  EmailAuthProviderCubit(super.initialState);

  @override
  Future<String?> accessToken() {
    throw UnimplementedError();
  }

  @override
  Future<bool> signIn([AuthProviderCubitParams? params]) {
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() {
    throw UnimplementedError();
  }
}

class PhoneAuthProviderCubit
    extends AuthProviderCubit<AuthProviderCubitParams> {
  PhoneAuthProviderCubit(super.initialState);

  @override
  Future<String?> accessToken() {
    throw UnimplementedError();
  }

  @override
  Future<bool> signIn([AuthProviderCubitParams? params]) {
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() {
    throw UnimplementedError();
  }
}

void main() {
  group('AuthProviderCubit', () {
    test(
        'Two instanciation of the same provider is detected as the same even with different state',
        () {
      expect(
        PhoneAuthProviderCubit(AuthProviderState.unauthenticated()),
        PhoneAuthProviderCubit(
          AuthProviderState.authenticated(),
        ),
      );
      expect(
        PhoneAuthProviderCubit(AuthProviderState.authenticated()),
        PhoneAuthProviderCubit(
          AuthProviderState.unauthenticated(),
        ),
      );

      expect(
        EmailAuthProviderCubit(AuthProviderState.unauthenticated()),
        EmailAuthProviderCubit(
          AuthProviderState.authenticated(),
        ),
      );
      expect(
        EmailAuthProviderCubit(AuthProviderState.authenticated()),
        EmailAuthProviderCubit(
          AuthProviderState.unauthenticated(),
        ),
      );

      expect(
        EmailAuthProviderCubit(AuthProviderState.authenticated()).hashCode,
        EmailAuthProviderCubit(AuthProviderState.unauthenticated()).hashCode,
      );

      expect(
        EmailAuthProviderCubit(AuthProviderState.authenticated()).hashCode ==
            PhoneAuthProviderCubit(AuthProviderState.authenticated()).hashCode,
        false,
      );

      expect(
        EmailAuthProviderCubit(AuthProviderState.authenticated()).hash(''),
        EmailAuthProviderCubit(AuthProviderState.unauthenticated()).hash(''),
      );

      expect(
        EmailAuthProviderCubit(AuthProviderState.authenticated()).hash('') ==
            PhoneAuthProviderCubit(AuthProviderState.authenticated()).hash(''),
        false,
      );

      expect(
          EmailAuthProviderCubit(AuthProviderState.authenticated()).equals(
            EmailAuthProviderCubit(AuthProviderState.unauthenticated()),
            EmailAuthProviderCubit(AuthProviderState.authenticated()),
          ),
          true);

      expect(
        EmailAuthProviderCubit(AuthProviderState.authenticated()).equals(
          PhoneAuthProviderCubit(AuthProviderState.unauthenticated()),
          EmailAuthProviderCubit(AuthProviderState.authenticated()),
        ),
        false,
      );

      expect(
          EmailAuthProviderCubit(AuthProviderState.authenticated()) ==
              EmailAuthProviderCubit(AuthProviderState.unauthenticated()),
          true);

      expect(
        EmailAuthProviderCubit(AuthProviderState.authenticated()) ==
            PhoneAuthProviderCubit(AuthProviderState.authenticated()),
        false,
      );

      expect(
        EmailAuthProviderCubit(AuthProviderState.authenticated()).isValidKey(
            EmailAuthProviderCubit(AuthProviderState.unauthenticated())),
        true,
      );
      expect(
        EmailAuthProviderCubit(AuthProviderState.authenticated()).isValidKey(
            PhoneAuthProviderCubit(AuthProviderState.authenticated())),
        false,
      );
    });
  });
}
