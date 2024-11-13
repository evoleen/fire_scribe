import 'package:dio/dio.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:fire_scribe/app_logger.dart';
import 'package:fire_scribe/auth/providers/auth_provider.dart';
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
  const factory AuthState.authenticated({
    required String url,
    required AuthProvider provider,
  }) = _Authenticated;
}

// A Cubit responsible for orchestrating authentication operations across
// multiple authentication providers.
///
/// This Cubit manages the authentication flow by coordinating actions across a list
/// of authentication providers.

///
/// Example usage:
/// ```dart
/// final authCubit = AuthCubit();
/// await authCubit.connect(url, providerA);
/// await authCubit.connect(url, providerB);
/// ```
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(_Unauthenticated());

  Future<bool> authenticate({
    required final String url,
    required final AuthProvider authProvider,
  }) async {
    final token = await authProvider.accessToken();
    final client = FhirRestClient(
      dio: Dio(
        BaseOptions(
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      ),
      baseUrl: Uri.parse(url),
    );

    try {
      await client.execute(
        request: FhirRequest(
          operation: FhirRequestOperation.search,
          entityName: 'Patient',
          parameters: {
            'count': '1',
          },
        ),
      );
      emit(_Authenticated(url: url, provider: authProvider));
      return true;
    } catch (e) {
      AppLogger.instance.e(e);
      return false;
    }
  }

  Future<String?> accessToken() async {
    return state.maybeWhen(
      authenticated: (_, provider) => provider.accessToken(),
      orElse: () => null,
    );
  }
}
