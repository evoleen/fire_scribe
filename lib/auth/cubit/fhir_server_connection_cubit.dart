import 'package:dio/dio.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:fire_scribe/app_logger.dart';
import 'package:fire_scribe/auth/providers/token_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'fhir_server_connection_cubit.freezed.dart';

@freezed
class FhirServerConnectionCubitState with _$FhirServerConnectionCubitState {
  /// Represents the unauthenticated state, indicating that the user
  /// is not currently authenticated.
  const factory FhirServerConnectionCubitState.unauthenticated() =
      _Unauthenticated;

  /// Represents the authenticated state, indicating that the user is authenticated
  /// with one or more providers.
  ///
  /// [provider]: The current provider which is using for authenticate connection
  const factory FhirServerConnectionCubitState.authenticated({
    required TokenProvider provider,
    required FhirRestClient fhirRestClient,
  }) = _Authenticated;
}

// A Cubit responsible for orchestrating authentication operations across
// multiple authentication providers.
class FhirServerConnectionCubit extends Cubit<FhirServerConnectionCubitState> {
  final Talker talker;

  FhirServerConnectionCubit({
    required this.talker,
  }) : super(_Unauthenticated());

  /// This function allow users to authenticate with a FHIR Backend through custom providers
  /// If the provider is not able to stablish a successful connection, the cubit will move to
  /// [_Unauthenticated] state
  Future<bool> authenticate({
    required final String url,
    required final TokenProvider authProvider,
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
              settings: TalkerDioLoggerSettings(
                printRequestHeaders: true,
                printResponseHeaders: true,
              ),
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
      /// In order to check if connection is valid, we should make a query call
      /// expecting to not receive any error
      await client.execute(
        request: FhirRequest(
          operation: FhirRequestOperation.search,
          entityName: 'Patient',
          parameters: {
            '_count': '1',
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

  Future<String?> accessToken() async {
    return await state.maybeWhen(
      authenticated: (provider, _) async {
        try {
          return await provider.accessToken();
        } catch (e) {
          AppLogger.instance.e(e);
          return null;
        }
      },
      orElse: () => null,
    );
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
