import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:firearrow_admin_app/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'fhir_rest_client_cubit.freezed.dart';

@freezed
class FhirRestClientCubitState with _$FhirRestClientCubitState {
  const factory FhirRestClientCubitState.disconnected() = _Disconnected;
  const factory FhirRestClientCubitState.connected({
    /// The rest client to operate into cloud API
    required final FhirRestClient fhirRestClient,

    /// List of types that we could interact with
    required final List<String> schema,
  }) = _Connected;
}

class FhirRestClientCubit extends Cubit<FhirRestClientCubitState> {
  FhirRestClientCubit() : super(_Disconnected());

  void disconnect() {
    emit(_Disconnected());
  }

  void connect({
    required final Uri uri,
    required FutureOr<String?> Function() getToken,
  }) async {
    final token = await getToken();
    final fhirRestClient = FhirRestClient(
      dio: Dio(
        BaseOptions(
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
          headers: {
            'Accept': 'application/fhir+json',
            'Content-type': 'application/fhir+json',
            'Authorization': 'Bearer $token',
          },
        ),
      )..interceptors.add(
          TalkerDioLogger(
            talker: GetIt.instance.get<Talker>(),
            settings: TalkerDioLoggerSettings(
              printRequestData: kDebugMode,
              printRequestHeaders: kDebugMode,
              printResponseData: kDebugMode,
              printResponseHeaders: kDebugMode,
              printErrorData: kDebugMode,
              printErrorHeaders: kDebugMode,
              printErrorMessage: kDebugMode,
              printResponseMessage: kDebugMode,
            ),
          ),
        ),
      baseUrl: uri,
    );

    try {
      final schema = await fhirRestClient.getSchema();
      emit(_Connected(
        fhirRestClient: fhirRestClient,
        schema: schema,
      ));
    } catch (e) {
      AppLogger.instance.e(e);
    }
  }
}
