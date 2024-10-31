import 'dart:convert';

import 'package:firearrow_admin_app/dashboard/widgets/dashboard_entity_list.dart';
import 'package:firearrow_admin_app/dashboard/widgets/server_url_form.dart';
import 'package:firearrow_admin_app/editor/entity_editor_bottom_sheet.dart';
import 'package:firearrow_admin_app/editor/patient_json.dart';
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
                ServerUrlForm(),
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
                        entityDataJson: jsonEncode(patientJson),
                      ),
                      child: Text('Open Editor'),
                    ),
                  ),
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
    );
  }
}
