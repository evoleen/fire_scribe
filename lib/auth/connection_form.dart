import 'package:fire_scribe/auth/azure_identity_connection_form.dart';
import 'package:fire_scribe/auth/url_token_connection_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConnectionForm extends StatefulWidget {
  const ConnectionForm({super.key});

  @override
  State<ConnectionForm> createState() => _ConnectionFormState();
}

class _ConnectionFormState extends State<ConnectionForm> {
  var useUrlTokenForm = kIsWeb;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                useUrlTokenForm = !useUrlTokenForm;
              });
            },
            child: Text(
              useUrlTokenForm
                  ? 'Login with Azure Identity'
                  : 'Login with Bearer token',
            ),
          ),
          SizedBox(height: 16),
          useUrlTokenForm
              ? UrlTokenConnectionForm()
              : AzureIdentityConnectionForm(),
        ],
      ),
    );
  }
}
