import 'package:file_picker/file_picker.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

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
  PlatformFile? selectedFile;

  /// Opens a file picker to select an NDJSON file
  Future<void> selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['ndjson', 'json'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedFile = result.files.first;
        });
      }
    } catch (e) {
      // Handle file picker errors silently for now
      // In a production app, you might want to show a snackbar or dialog
    }
  }

  /// Handles the import button press
  void handleImport() {
    // TODO: Implement import functionality
    // This will be implemented in subsequent steps
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

            // File picker section
            Text(
              S.of(context).ndjsonFileToImport,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      selectedFile?.name ?? S.of(context).noFileSelected,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            selectedFile != null
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: selectFile,
                  icon: const Icon(Icons.folder_open),
                  label: Text(S.of(context).selectFile),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Import button
            FilledButton.icon(
              onPressed: selectedFile != null ? handleImport : null,
              icon: const Icon(Icons.upload),
              label: Text(S.of(context).import),
            ),
          ],
        ),
      ),
    );
  }
}
