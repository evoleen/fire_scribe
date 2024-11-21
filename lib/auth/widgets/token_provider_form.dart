import 'package:fire_scribe/auth/widgets/bearer_token_provider_form.dart';
import 'package:fire_scribe/auth/widgets/token_provider_desktop_form.dart';
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
