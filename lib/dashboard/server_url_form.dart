import 'package:firearrow_admin_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ServerUrlForm extends StatefulWidget {
  const ServerUrlForm({super.key});

  @override
  State<ServerUrlForm> createState() => _ServerUrlFormState();
}

class _ServerUrlFormState extends State<ServerUrlForm> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: S.of(context).introduceServerUrl,
          labelText: S.of(context).serverUrl,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
