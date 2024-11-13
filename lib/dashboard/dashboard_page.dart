import 'package:fire_scribe/auth/auth_cubit/auth_cubit.dart';
import 'package:fire_scribe/auth/connection_form.dart';
import 'package:fire_scribe/dashboard/cubit/dashboard_cubit.dart';
import 'package:fire_scribe/dashboard/widgets/dashboard_left_panel.dart';
import 'package:fire_scribe/dashboard/widgets/entity_data_paginated_list.dart';
import 'package:fire_scribe/dashboard/widgets/entity_type_list.dart';
import 'package:fire_scribe/fhir_server/fhir_server_repository.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DashboardPage extends StatelessWidget with WidgetsBindingObserver {
  const DashboardPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.when(
          authenticated: (url, provider) {
            return RepositoryProvider<FhirServerRepository>(
              create: (context) => FhirServerRepository(
                serverUrl: url,
                talker: GetIt.instance<Talker>(),
                accessToken: () => provider.accessToken(),
              ),
              child: BlocProvider(
                create: (context) => DashboardCubit(),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DashboardLeftPanel(
                        child: EntityTypeList(),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: ColoredBox(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        child: Column(
                          children: const [
                            ConnectionForm(),
                            Expanded(
                              child: EntityDataPaginatedList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          unauthenticated: () => Row(
            children: [
              Flexible(
                flex: 1,
                child: DashboardLeftPanel(),
              ),
              Flexible(
                flex: 3,
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  child: Column(
                    children: [
                      ConnectionForm(),
                      Expanded(
                        child: Center(
                          child: Text(
                            S.of(context).connectToServerHelpText,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
