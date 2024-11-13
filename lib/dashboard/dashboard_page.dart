import 'package:fire_scribe/auth/cubit/fhir_server_connection_cubit.dart';
import 'package:fire_scribe/auth/widgets/connection_form.dart';
import 'package:fire_scribe/dashboard/cubit/dashboard_cubit.dart';
import 'package:fire_scribe/dashboard/widgets/dashboard_left_panel.dart';
import 'package:fire_scribe/dashboard/widgets/entity_data_paginated_list.dart';
import 'package:fire_scribe/dashboard/widgets/entity_type_list.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget with WidgetsBindingObserver {
  const DashboardPage();

  @override
  Widget build(BuildContext context) {
    const connectionFormKey = Key('ConnectionForm');
    return BlocBuilder<FhirServerConnectionCubit,
        FhirServerConnectionCubitState>(
      builder: (context, state) {
        return state.when(
          authenticated: (url, provider) {
            return BlocProvider(
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
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      child: Column(
                        children: const [
                          ConnectionForm(
                            key: connectionFormKey,
                          ),
                          Expanded(
                            child: EntityDataPaginatedList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                      ConnectionForm(
                        key: connectionFormKey,
                      ),
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
