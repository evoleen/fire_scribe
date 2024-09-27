import 'package:auth_cubit/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:firearrow_admin_app/app_logger.dart';
import 'package:firearrow_admin_app/auth/azure_identity_provider_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'connection_cubit.freezed.dart';

@freezed
class ConnectionState with _$ConnectionState {
  const factory ConnectionState.disconnected() = _Disconnected;
  const factory ConnectionState.connected(
      {required final GraphQLClient graphQLClient}) = _Connected;
}

class ConnectionCubit extends Cubit<ConnectionState> {
  ConnectionCubit() : super(_Disconnected());

  void disconnect() {
    emit(_Disconnected());
  }

  void connect({required final Uri uri}) {
    final graphQLClient = GraphQLClient(
      link: Link.from(
        [
          AuthLink(
            getToken: () async {
              final token = await GetIt.instance
                  .get<AuthCubit>()
                  .provider<AzureIdentityProviderCubit>()
                  .accessToken();
              if (kDebugMode) {
                AppLogger.instance.d('Bearer $token');
              }

              if (token == null) {
                return null;
              }

              return 'Bearer $token';
            },
          ),
          DioLink(
            uri.toString(),
            client: Dio(
              BaseOptions(
                connectTimeout: const Duration(milliseconds: 30000),
                receiveTimeout: const Duration(milliseconds: 30000),
              ),
            )..interceptors.add(
                TalkerDioLogger(
                  talker: GetIt.instance.get<Talker>(),
                  settings: TalkerDioLoggerSettings(
                    printResponseData: kDebugMode,
                    printRequestData: kDebugMode,
                  ),
                ),
              ),
          ),
        ],
      ),
      cache: GraphQLCache(),
    );
    emit(_Connected(graphQLClient: graphQLClient));
  }
}
