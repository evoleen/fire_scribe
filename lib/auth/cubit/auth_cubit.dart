import 'package:dio/dio.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:fire_scribe/app_logger.dart';
import 'package:fire_scribe/auth/providers/auth_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
    required AuthProvider provider,
    required FhirRestClient fhirRestClient,
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
  final Talker talker;

  AuthCubit({
    required this.talker,
  }) : super(_Unauthenticated());

  Future<bool> authenticate({
    required final String url,
    required final AuthProvider authProvider,
  }) async {
    final client = FhirRestClient(
      dio: Dio(
        BaseOptions(
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
        ),
      )..interceptors.addAll(
          [
            TalkerDioLogger(
              talker: talker,
              settings: TalkerDioLoggerSettings(),
            ),
            InterceptorsWrapper(
              onRequest: (options, handler) async {
                final token = await authProvider.accessToken();
                if (token == null) {
                  talker.warning(
                      'Unable to retrieve authentication token, request will most likely fail.');
                } else {
                  options.headers['Authorization'] = 'Bearer $token';
                }
                return handler.next(options);
              },
            ),
          ],
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
      emit(_Authenticated(
        provider: authProvider,
        fhirRestClient: client,
      ));
      return true;
    } catch (e) {
      emit(_Unauthenticated());
      AppLogger.instance.e(e);
      return false;
    }
  }

  Future<Map<String, dynamic>?> request({required FhirRequest request}) async {
    return await state.maybeWhen(
      authenticated: (_, client) async {
        try {
          return await client.execute(request: request);
        } catch (e) {
          AppLogger.instance.e(e);
          return null;
        }
      },
      orElse: () => null,
    );
  }

  Future<List<String>> getListOfSchemaEntities() async {
    return await state.maybeWhen(
      authenticated: (_, client) async {
        try {
          final capabilities = await client.getCapabilityStatement();
          final resources =
              capabilities['rest'][0]['resource'] as List<dynamic>;
          return resources.map((item) => item['type']).cast<String>().toList();
        } catch (e) {
          AppLogger.instance.e(e);
          return [];
        }
      },
      orElse: () => [],
    );
  }
}
