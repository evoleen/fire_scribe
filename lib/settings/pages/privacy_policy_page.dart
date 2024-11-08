import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).pageComingSoon,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
