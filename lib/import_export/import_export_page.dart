import 'package:dio/dio.dart';
import 'package:fire_scribe/auth/cubit/fhir_server_connection_cubit.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A page for handling import and export functionality of FHIR resources.
///
/// This page provides a user interface for importing FHIR resources from external
/// sources and exporting resources to various formats. The content will be
/// implemented in subsequent steps.
class ImportExportPage extends StatefulWidget {
  const ImportExportPage({super.key});

  @override
  State<ImportExportPage> createState() => _ImportExportPageState();
}

class _ImportExportPageState extends State<ImportExportPage> {
  final TextEditingController _urlController = TextEditingController();
  final FocusNode _urlFocusNode = FocusNode();

  @override
  void dispose() {
    _urlController.dispose();
    _urlFocusNode.dispose();
    super.dispose();
  }

  /// Handles the import button press
  Future<void> handleImport() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      return;
    }

    try {
      final connectionCubit = BlocProvider.of<FhirServerConnectionCubit>(
        context,
      );

      // Check if we're authenticated
      final isAuthenticated = connectionCubit.state.maybeWhen(
        authenticated: (_, __) => true,
        orElse: () => false,
      );

      if (!isAuthenticated) {
        // Show error message that user needs to be connected to a server
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(S.of(context).connectionRequired),
              content: Text(S.of(context).connectionRequiredMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(S.of(context).ok),
                ),
              ],
            );
          },
        );
        return;
      }

      // Get the FHIR client from the authenticated state
      final fhirClient = connectionCubit.state.maybeWhen(
        authenticated: (_, client) => client,
        orElse: () => null,
      );

      if (fhirClient == null) {
        // TODO: Show error message
        return;
      }

      // Make the import request using the underlying Dio client
      final response = await fhirClient.dio.post(
        '/\$import',
        data: {
          'resourceType': 'Parameters',
          'parameter': [
            {'name': 'inputFormat', 'valueString': 'application/fhir+ndjson'},
            {
              'name': 'input',
              'part': [
                {'name': 'url', 'valueUri': url},
              ],
            },
          ],
        },
        options: Options(
          headers: {
            'Prefer': 'respond-async',
            'Content-Type': 'application/fhir+json',
          },
        ),
      );

      // Handle the response based on status code
      if (response.statusCode.toString().startsWith("2")) {
        // Success - import started
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(S.of(context).importStarted),
              content: Text(S.of(context).importStartedMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(S.of(context).ok),
                ),
              ],
            );
          },
        );
      } else {
        // Unexpected response - show failure
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(S.of(context).importFailed),
              content: Text(
                S
                    .of(context)
                    .importFailedMessage(
                      'Status: ${response.statusCode}\nResponse: ${response.data}',
                    ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(S.of(context).ok),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Show error dialog with the exception details
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).importError),
            content: Text(S.of(context).importErrorMessage(e.toString())),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(S.of(context).ok),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Row(
              children: [
                Icon(
                  Icons.import_export,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  S.of(context).importExport,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).importExportDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),

            // URL input section
            Text(
              S.of(context).ndjsonFileToImport,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _urlController,
              focusNode: _urlFocusNode,
              decoration: InputDecoration(
                hintText: 'https://example.com/fhir/resources.ndjson',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.link),
              ),
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => handleImport(),
            ),
            const SizedBox(height: 24),

            // Import button
            FilledButton.icon(
              onPressed:
                  _urlController.text.trim().isNotEmpty ? handleImport : null,
              icon: const Icon(Icons.upload),
              label: Text(S.of(context).import),
            ),
          ],
        ),
      ),
    );
  }
}
