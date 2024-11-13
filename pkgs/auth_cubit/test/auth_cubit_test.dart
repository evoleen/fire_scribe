import 'package:auth_cubit/auth_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthProviderCubit extends Mock
    implements AuthProviderCubit<AuthProviderCubitParams> {}

class MockAuthProviderCubit2 extends Mock
    implements AuthProviderCubit<AuthProviderCubitParams> {}

void main() {
  group('AuthCubit', () {
    late MockAuthProviderCubit authProvider1;
    late MockAuthProviderCubit2 authProvider2;

    setUp(() {
      authProvider1 = MockAuthProviderCubit();
      authProvider2 = MockAuthProviderCubit2();
    });

    blocTest<AuthCubit, AuthState>(
      'initial state is unauthenticated',
      build: () => AuthCubit(providers: {}),
      verify: (bloc) {
        expect(bloc.state, AuthState.unauthenticated());
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits authenticated state after successful sign-in',
      build: () {
        when(() => authProvider1.state)
            .thenAnswer((_) => AuthProviderState.authenticated());
        when(() => authProvider1.stream)
            .thenAnswer((_) => Stream.value(AuthProviderState.authenticated()));

        when(() => authProvider2.state)
            .thenAnswer((_) => AuthProviderState.authenticated());
        when(() => authProvider2.stream)
            .thenAnswer((_) => Stream.value(AuthProviderState.authenticated()));

        return AuthCubit(providers: {authProvider1, authProvider2});
      },
      verify: (bloc) {
        expect(
          bloc.state,
          AuthState.authenticated(
            providers: {
              MockAuthProviderCubit,
              MockAuthProviderCubit2,
            },
          ),
        );
      },
    );

    blocTest<AuthCubit, AuthState>(
        'emits unauthenticated state after successful sign-out',
        build: () {
          when(() => authProvider1.state)
              .thenAnswer((_) => AuthProviderState.unauthenticated());
          when(() => authProvider1.stream).thenAnswer(
              (_) => Stream.value(AuthProviderState.unauthenticated()));

          when(() => authProvider2.state)
              .thenAnswer((_) => AuthProviderState.authenticated());
          when(() => authProvider2.stream).thenAnswer(
              (_) => Stream.value(AuthProviderState.authenticated()));

          return AuthCubit(providers: {authProvider1, authProvider2});
        },
        seed: () => AuthState.authenticated(providers: {
              MockAuthProviderCubit,
              MockAuthProviderCubit2,
            }),
        verify: (cubit) {
          expect(
            cubit.state,
            AuthState.authenticated(
              providers: {MockAuthProviderCubit2},
            ),
          );
        });

    blocTest<AuthCubit, AuthState>(
      'returns correct provider instance',
      build: () {
        when(() => authProvider1.state)
            .thenAnswer((_) => AuthProviderState.unauthenticated());
        when(() => authProvider1.stream).thenAnswer(
            (_) => Stream.value(AuthProviderState.unauthenticated()));

        when(() => authProvider2.state)
            .thenAnswer((_) => AuthProviderState.unauthenticated());
        when(() => authProvider2.stream).thenAnswer(
            (_) => Stream.value(AuthProviderState.unauthenticated()));

        return AuthCubit(
          providers: {
            authProvider1,
            authProvider2,
          },
        );
      },
      verify: (cubit) {
        expect(cubit.provider<MockAuthProviderCubit>(), authProvider1);
        expect(cubit.provider<MockAuthProviderCubit2>(), authProvider2);
      },
    );
  });
}
