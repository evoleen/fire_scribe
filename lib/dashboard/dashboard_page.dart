import 'package:firearrow_admin_app/connection/connection_form.dart';
import 'package:firearrow_admin_app/connection/cubit/fhir_rest_client_cubit.dart';
import 'package:firearrow_admin_app/dashboard/widgets/dashboard_entity_data_display.dart';
import 'package:firearrow_admin_app/dashboard/widgets/dashboard_entity_list.dart';
import 'package:firearrow_admin_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: DashboardEntityList(),
        ),
        Expanded(
          flex: 3,
          child: ColoredBox(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: Column(
              children: [
                ConnectionForm(),
                BlocConsumer<FhirRestClientCubit, FhirRestClientCubitState>(
                  listener: (context, state) {
                    state.when(
                      disconnected: () {},
                      connected: (graphQLClient) {},
                    );
                  },
                  builder: (context, state) {
                    return state.when(
                      connected: (_) => DashboardEntityDataDisplay(),
                      disconnected: () {
                        return Center(
                          child: Text(
                            S.of(context).connectToServerHelpText,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
