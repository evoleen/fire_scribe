import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_provider_cubit.freezed.dart';

@freezed
class AuthProviderState<T> with _$AuthProviderState {
  /// This state represents the initial state of the authentication process,
  /// indicating that the user is not currently authenticated. It could be used to display
  /// a login/signup screen or any other UI relevant to unauthenticated users.
  const factory AuthProviderState.unauthenticated() = _Unauthenticated;

  /// This state signifies that the user has been successfully authenticated. The
  /// optional data parameter can hold any relevant user data or authentication
  /// tokens obtained during the authentication process
  const factory AuthProviderState.authenticated({T? data}) = _Authenticated;
}

/// Abstract base class for parameters used in authentication-related operations.
///
/// This class serves as a base for defining parameter objects used by authentication methods
/// within the [AuthProviderCubit]. It allows for type-safe and structured passing of
/// authentication parameters.
///
/// Example usage:
/// ```dart
/// class EmailPasswordParams extends AuthParams {
///   final String email;
///   final String password;
///
///   EmailPasswordParams(this.email, this.password);
/// }
///
/// final params = EmailPasswordParams('user@example.com', 'password123');
/// ```
abstract class AuthProviderCubitParams {}

/// Abstract base class for a Cubit responsible for managing authentication state and providing authentication-related functions.
///
/// This Cubit integrates with the overall authentication flow managed by the AuthBloc.
/// It handles authentication operations such as signing in, two-factor authentication, signing out, and retrieving access tokens.
/// Subclasses of `AuthProviderCubit` should implement authentication logic specific to their authentication provider.
///
/// Example usage:
/// ```dart
/// class EmailAuthProviderCubit extends AuthProviderCubit<EmailAuthParams> {
///   EmailAuthProviderCubit() : super(const AuthProviderState.unauthenticated());
/// }
/// ```
abstract class AuthProviderCubit<Params extends AuthProviderCubitParams>
    extends Cubit<AuthProviderState> implements Equality {
  /// Constructs an instance of [AuthProviderCubit] with the specified initial state.
  ///
  /// [initialState]: The initial state of the authentication provider.
  AuthProviderCubit(super.initialState);

  /// Initiates the sign-in process with optional parameters.
  ///
  /// Returns a [Future] indicating whether the sign-in process succeeded.
  ///
  /// May throw an Exception if the sign-in process encounters an error.
  ///
  /// [params]: An instance of a subclass of [AuthProviderCubitParams] containing sign-in parameters.
  Future<bool> signIn([Params? params]);

  /// Signs out the current user.
  ///
  /// Returns a [Future] indicating the completion of the sign-out process.
  ///
  /// May throw an Exception if the sign-out process encounters an error.
  Future<bool> signOut();

  /// Retrieves the access token for the authenticated user.
  ///
  /// Returns a [Future] containing the access token as a String, or `null` if not available.
  ///
  /// May throw an Exception if the access token retrieval encounters an error.
  Future<String?> accessToken();

  /// Overrides the `==` operator to ensure that only one instance of each type of provider exists within a collection.
  @override
  bool operator ==(Object other) => runtimeType == other.runtimeType;

  /// Generates the hash code for the authentication provider type.
  @override
  int get hashCode => runtimeType.hashCode;

  /// Checks if two instances of the authentication provider type are equal.
  @override
  bool equals(e1, e2) => e1.runtimeType == e2.runtimeType;

  /// Generates the hash code for an instance of the authentication provider type.
  @override
  int hash(e) => runtimeType.hashCode;

  /// Checks if the provided object is a valid key for this authentication provider type.
  @override
  bool isValidKey(Object? o) => o.runtimeType == runtimeType;
}
