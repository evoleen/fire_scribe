import 'package:fhir/r4.dart';
import 'package:fire_scribe/auth/connection_form.dart';
import 'package:fire_scribe/auth/cubit/auth_cubit.dart';
import 'package:fire_scribe/auth/cubit/auth_provider_cubit.dart';
import 'package:fire_scribe/auth/providers/azure_identity_provider_cubit.dart';
import 'package:fire_scribe/dashboard/cubit/dashboard_cubit.dart';
import 'package:fire_scribe/dashboard/widgets/dashboard_left_panel.dart';
import 'package:fire_scribe/dashboard/widgets/entity_data_paginated_list.dart';
import 'package:fire_scribe/dashboard/widgets/entity_type_list.dart';
import 'package:fire_scribe/editor/entity_editor_bottom_sheet.dart';
import 'package:fire_scribe/editor/patient_json.dart';
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
    return BlocBuilder<AuthProviderCubit, AuthProviderState>(
      bloc: BlocProvider.of<AuthCubit>(context)
          .provider<AzureIdentityProviderCubit>(),
      builder: (context, state) {
        return state.when(
          authenticated: (data) {
            return RepositoryProvider(
              create: (context) => FhirServerRepository(
                serverUrl: data,
                talker: GetIt.instance<Talker>(),
                accessToken: () => BlocProvider.of<AuthCubit>(context)
                    .provider<AzureIdentityProviderCubit>()
                    .accessToken(),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () => EntityEditorBottonSheet.show(
                              context,
                              resource: Resource.fromJson(patientJson),
                            ),
                            child: Text('Open Editor'),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          S.of(context).connectToServerHelpText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          preAuthenticated: (_) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
