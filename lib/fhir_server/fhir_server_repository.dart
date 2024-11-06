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

  FhirServerRepository({
    required this.serverUrl,
    required this.talker,
    required this.accessToken,
  });

  /// This functions creates a new Client each time is called,
  /// In that way it could ensure we always have the more fresh token
  /// available
  Future<FhirRestClient> _client() async {
    final accessToken = await this.accessToken();
    return FhirRestClient(
      dio: Dio(
        BaseOptions(
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      )..interceptors.add(
          TalkerDioLogger(
            talker: talker,
            settings: TalkerDioLoggerSettings(),
          ),
        ),
      baseUrl: Uri.parse(serverUrl),
    );
  }

  Future<List<String>> getListOfSchemaEntities() async {
    try {
      final capabilities = await (await _client()).getCapabilityStatement();
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
      return await (await _client()).execute(request: request);
    } catch (e) {
      AppLogger.instance.e(e);
      return null;
    }
  }
}
