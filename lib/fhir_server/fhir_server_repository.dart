import 'package:dio/dio.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:firearrow_admin_app/app_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FhirServerRepository {
  final String serverUrl;
  final Future<String?> Function() accessToken;
  final Talker talker;

  late FhirRestClient _client;

  FhirServerRepository({
    required this.serverUrl,
    required this.talker,
    required this.accessToken,
  }) {
    _client = FhirRestClient(
      dio: Dio(
        BaseOptions(
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
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
      return resources
          .where((item) =>
              item is Map<String, dynamic> &&
              item.containsKey('interaction') &&
              (item['interaction'] as List).isNotEmpty)
          .map((item) => item['type'])
          .cast<String>()
          .toList();
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
