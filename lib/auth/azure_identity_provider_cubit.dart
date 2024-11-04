import 'package:auth_cubit/auth_cubit.dart';
import 'package:azure_identity/azure_identity.dart';
import 'package:dio/dio.dart';
import 'package:fhir_rest_client/fhir_rest_client.dart';
import 'package:firearrow_admin_app/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AzureHealthDataServiceConnection {
  /// The rest client to operate into cloud API
  final FhirRestClient fhirRestClient;

  /// List of types that we could interact with
  final List<String> schema;

  AzureHealthDataServiceConnection({
    required this.fhirRestClient,
    required this.schema,
  });
}

class AzureIdentityProviderCubitParams extends AuthProviderCubitParams {
  final String serverUrl;

  AzureIdentityProviderCubitParams({
    required this.serverUrl,
  });
}

/// This auth provider is designed to authenticate into Azure Health Data Service
/// In is authenticated state, will offer a [AzureHealthDataServiceConnection] for
/// having the connection configuration to interact with the data
class AzureIdentityProviderCubit
    extends AuthProviderCubit<AzureIdentityProviderCubitParams> {
  final DefaultAzureCredential defaultAzureCredential;
  final Talker talker;

  CredentialManager? _credentialManager;

  AzureIdentityProviderCubit({
    required this.defaultAzureCredential,
    required this.talker,
  }) : super(const AuthProviderState.unauthenticated());

  @override
  Future<bool> signIn([AzureIdentityProviderCubitParams? params]) async {
    if (params == null) {
      return false;
    }
    _credentialManager = CredentialManager(
      credential: defaultAzureCredential,
      options: GetTokenOptions(
        scopes: [
          params.serverUrl,
        ],
      ),
    );

    try {
      final token = await _credentialManager!.getAccessToken();
      if (token?.token != null) {
        final fhirRestClient = FhirRestClient(
          dio: Dio(
            BaseOptions(
              connectTimeout: const Duration(milliseconds: 30000),
              receiveTimeout: const Duration(milliseconds: 30000),
              headers: {
                'Accept': 'application/fhir+json',
                'Content-type': 'application/fhir+json',
                'Authorization': await () async {
                  final token = await accessToken();
                  final authorizationHeader = 'Bearer $token';
                  if (kDebugMode) {
                    AppLogger.instance.d(authorizationHeader);
                  }
                  return authorizationHeader;
                }(),
              },
            ),
          )..interceptors.add(
              TalkerDioLogger(
                talker: talker,
                settings: TalkerDioLoggerSettings(),
              ),
            ),
          baseUrl: Uri.parse(params.serverUrl),
        );
        final azureHealthDataServiceConnection =
            AzureHealthDataServiceConnection(
          fhirRestClient: fhirRestClient,
          schema: await fhirRestClient.getSchema(),
        );

        emit(
          AuthProviderState.authenticated(
            data: azureHealthDataServiceConnection,
          ),
        );
      } else {
        emit(AuthProviderState.unauthenticated());
      }
      return token?.token != null;
    } catch (e) {
      AppLogger.instance.e(e);
      emit(AuthProviderState.unauthenticated());
      return false;
    }
  }

  @override
  Future<bool> signIn2FA([AuthProviderCubitParams? params]) async {
    return false;
  }

  @override
  Future<bool> signOut() async {
    _credentialManager = null;
    emit(AuthProviderState.unauthenticated());
    return true;
  }

  @override
  Future<String?> accessToken() async {
    final token = await _credentialManager?.getAccessToken();
    if (token?.token == null) {
      emit(AuthProviderState.unauthenticated());
    }
    return token?.token;
  }
}
