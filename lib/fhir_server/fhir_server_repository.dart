import 'package:dio/dio.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:firearrow_admin_app/app_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FhirServerRepository {
  late FhirRestClient _client;

  FhirServerRepository({
    required final String serverUrl,
    required final Talker talker,
    required final Future<String?> Function() accessToken,
  }) {
    _client = FhirRestClient(
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
                final token = await accessToken();
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
      baseUrl: Uri.parse(serverUrl),
    );
  }

  Future<List<String>> getListOfSchemaEntities() async {
    try {
      final capabilities = await _client.getCapabilityStatement();
      final resources = capabilities['rest'][0]['resource'] as List<dynamic>;
      return resources.map((item) => item['type']).cast<String>().toList();
    } catch (e) {
      AppLogger.instance.e(e);
      return [];
    }
  }

  Future<Map<String, dynamic>?> request({required FhirRequest request}) async {
    try {
      return await _client.execute(request: request);
    } catch (e) {
      AppLogger.instance.e(e);
      return null;
    }
  }
}
