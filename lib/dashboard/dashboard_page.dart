import 'package:auth_cubit/auth_cubit.dart';
import 'package:firearrow_admin_app/auth/azure_identity_provider_cubit.dart';
import 'package:firearrow_admin_app/auth/connection_form.dart';
import 'package:firearrow_admin_app/dashboard/cubit/dashboard_cubit.dart';
import 'package:firearrow_admin_app/dashboard/widgets/dashboard_entity_data_display.dart';
import 'package:firearrow_admin_app/dashboard/widgets/dashboard_entity_list.dart';
import 'package:firearrow_admin_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthProviderCubit, AuthProviderState>(
      bloc: BlocProvider.of<AuthCubit>(context)
          .provider<AzureIdentityProviderCubit>(),
      builder: (context, state) {
        return state.when(
          authenticated: (data) {
            return BlocProvider(
              create: (context) =>
                  DashboardCubit()..select(entityType: data.schema.first),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: DashboardEntityList(
                      listOfEntities: data.schema,
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: ColoredBox(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      child: Column(
                        children: [
                          ConnectionForm(),
                          Expanded(
                            child: BlocBuilder<DashboardCubit,
                                DashboardCubitState>(
                              builder: (context, state) {
                                return state.when(
                                  noselected: () => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  selected: (selectedEntityType) =>
                                      DashboardEntityDataDisplay(
                                    entityType: selectedEntityType,
                                    fhirRestClient: data.fhirRestClient,
                                  ),
                                );
                              },
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
          unauthenticated: () => Row(
            children: [
              Flexible(
                flex: 1,
                child: DashboardEntityList(listOfEntities: const []),
              ),
              Flexible(
                flex: 3,
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  child: Column(
                    children: [
                      ConnectionForm(),
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
