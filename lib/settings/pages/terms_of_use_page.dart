import 'package:firearrow_admin_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
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
