import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:evoleen_fhir/evoleen_fhir.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'fhir_repositories_cubit.freezed.dart';

@freezed
class FhirRepositoriesCubitState with _$FhirRepositoriesCubitState {
  const factory FhirRepositoriesCubitState.disconnected() = _Disconnected;
  const factory FhirRepositoriesCubitState.connected(
          {required final List<EvoleenFhirGqlRepository> repositories}) =
      _Connected;
}

class FhirRepositoriesCubit extends Cubit<FhirRepositoriesCubitState> {
  FhirRepositoriesCubit() : super(_Disconnected());

  void disconnect() {
    emit(_Disconnected());
  }

  void connect({
    required final Uri uri,
    required FutureOr<String?> Function() getToken,
  }) async {
    final graphQLClient = GraphQLClient(
      link: Link.from(
        [
          AuthLink(
            getToken: getToken,
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
    final repositories = EvoleenFhirSchema.entityToRepository.values
        .map(
          (repoBuilder) => repoBuilder(graphQLClient),
        )
        .whereNotNull()
        .toList();

    final patientRepo = repositories.firstWhereOrNull(
      (repository) => repository.baseType == Patient,
    );

    final patients = await patientRepo?.search();

    emit(_Connected(repositories: repositories));
  }
}
