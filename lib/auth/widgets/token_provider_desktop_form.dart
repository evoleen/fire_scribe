import 'package:fire_scribe/auth/widgets/azure_identity_token_provider_desktop_form.dart';
import 'package:fire_scribe/auth/widgets/bearer_token_provider_form.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

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
