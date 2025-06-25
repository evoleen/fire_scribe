import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// A page for handling import and export functionality of FHIR resources.
///
/// This page provides a user interface for importing FHIR resources from external
/// sources and exporting resources to various formats. The content will be
/// implemented in subsequent steps.
class ImportExportPage extends StatelessWidget {
  const ImportExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.import_export,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).importExport,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).importExportDescription,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
