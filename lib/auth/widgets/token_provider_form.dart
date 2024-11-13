import 'package:fire_scribe/auth/widgets/azure_identity_token_provider_desktop_form.dart';
import 'package:fire_scribe/auth/widgets/bearer_token_provider_form.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TokenProviderForm extends StatelessWidget {
  const TokenProviderForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: kIsWeb ? BearerTokenProviderForm() : TokenProviderDesktopForm(),
    );
  }
}

class TokenProviderDesktopForm extends StatefulWidget {
  const TokenProviderDesktopForm({super.key});

  @override
  State<TokenProviderDesktopForm> createState() =>
      _TokenProviderDesktopFormState();
}

class _TokenProviderDesktopFormState extends State<TokenProviderDesktopForm> {
  var usingAzureIdentityForm = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              usingAzureIdentityForm = !usingAzureIdentityForm;
            });
          },
          child: Text(
            usingAzureIdentityForm
                ? S.of(context).loginWithBearerToken
                : S.of(context).loginWithAzureIdentity,
          ),
        ),
        SizedBox(height: 16),
        usingAzureIdentityForm
            ? AzureIdentityTokenProviderForm()
            : BearerTokenProviderForm(),
      ],
    );
  }
}
