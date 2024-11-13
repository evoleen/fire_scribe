import 'dart:async';

import 'package:fire_scribe/auth/auth_cubit/auth_provider_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_cubit.freezed.dart';

@freezed
class AuthState with _$AuthState {
  /// Represents the unauthenticated state, indicating that the user
  /// is not currently authenticated.
  const factory AuthState.unauthenticated() = _Unauthenticated;

  /// Represents the authenticated state, indicating that the user is authenticated
  /// with one or more providers.
  ///
  /// [providers]: A set containing the types of providers the user is
  /// authenticated with.
  const factory AuthState.authenticated({required Set<Type> providers}) =
      _Authenticated;
}

// A Cubit responsible for orchestrating authentication operations across
//multiple authentication providers.
///
/// This Cubit manages the authentication flow by coordinating actions across a list
/// of authentication providers.
/// It handles operations such as signing in, signing out,
/// and retrieving access tokens from multiple providers.
///
/// Example usage:
/// ```dart
/// final authCubit = AuthCubit(providers: {authProvider1, authProvider2});
/// ```
class AuthCubit extends Cubit<AuthState> {
  final Set<AuthProviderCubit> _providers;

  late List<StreamSubscription<AuthProviderState<dynamic>>> _subscribers;

  /// Creates an instance of [AuthCubit] with the specified authentication providers.
  ///
  /// [providers]: A set containing the authentication providers to be managed by this [AuthCubit].
  ///
  /// Example usage:
  /// ```dart
  /// final emailAuthProvider = EmailAuthProviderCubit(authService);
  /// final phoneAuthProvider = PhoneAuthProviderCubit(authService);
  /// final authCubit = AuthCubit(providers: {emailAuthProvider, phoneAuthProvider});
  /// ```
  AuthCubit(
      {required final Set<AuthProviderCubit<AuthProviderCubitParams>>
          providers})
      : _providers = providers,
        super(_Unauthenticated()) {
    _subscribers = _providers
        .map((provider) => provider.stream.listen(_onProviderStateChanged))
        .toList();
  }

  void _onProviderStateChanged(AuthProviderState<dynamic> state) {
    final newProviders = _providers
        .where((provider) =>
            provider.state.runtimeType ==
            AuthProviderState.authenticated().runtimeType)
        .map((provider) => provider.runtimeType)
        .toSet();

    if (newProviders.isEmpty) {
      emit(AuthState.unauthenticated());
    } else {
      emit(AuthState.authenticated(providers: newProviders));
    }
  }

  @override
  Future<void> close() {
    for (final subscriber in _subscribers) {
      subscriber.cancel();
    }
    return super.close();
  }

  /// Retrieves the authentication provider of the specified type.
  ///
  /// This function returns the first authentication provider in the list of registered providers
  /// that matches the specified type. If no provider of the specified type is found, it throws
  /// a [StateError].
  ///
  /// [T]: The type of authentication provider to retrieve. It must be a subtype of [AuthProviderCubit].
  /// [Returns]: An instance of the specified authentication provider type.
  ///
  /// Example usage:
  /// ```dart
  /// final authProvider = authCubit.provider<EmailAuthProviderCubit>();
  /// ```
  T provider<T extends AuthProviderCubit>() {
    return _providers.firstWhere((element) => element is T) as T;
  }
}
