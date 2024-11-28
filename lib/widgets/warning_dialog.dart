import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class WarningDialog {
  static Future<bool?> show(
    final BuildContext context, {
    required final String warningMessage,
  }) =>
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(
              S.of(context).warning,
              textAlign: TextAlign.center,
            ),
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
            content: Text(
              warningMessage,
              textAlign: TextAlign.center,
            ),
            contentTextStyle: Theme.of(context).textTheme.bodyMedium,
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(S.of(context).cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(S.of(context).proceed),
              ),
            ],
          );
        },
      );
}
