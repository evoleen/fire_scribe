import 'package:fire_scribe/auth/widgets/azure_identity_token_provider_desktop_form.dart';
import 'package:fire_scribe/auth/widgets/bearer_token_provider_form.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TokenProviderForm extends StatefulWidget {
  const TokenProviderForm({super.key});

  @override
  State<TokenProviderForm> createState() => _TokenProviderFormState();
}

class _TokenProviderFormState extends State<TokenProviderForm> {
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
          if (!kIsWeb)
            TextButton(
              onPressed: () {
                setState(() {
                  useUrlTokenForm = !useUrlTokenForm;
                });
              },
              child: Text(
                useUrlTokenForm
                    ? S.of(context).loginWithAzureIdentity
                    : S.of(context).loginWithBearerToken,
              ),
            ),
          SizedBox(height: 16),
          useUrlTokenForm
              ? BearerTokenProviderForm()
              : AzureIdentityTokenProviderForm(),
        ],
      ),
    );
  }
}
