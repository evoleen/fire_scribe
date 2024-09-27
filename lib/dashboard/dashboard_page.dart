import 'package:firearrow_admin_app/connection/connection_form.dart';
import 'package:firearrow_admin_app/dashboard/widgets/dashboard_entity_list.dart';
import 'package:firearrow_admin_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
