import 'package:fire_scribe/auth/cubit/fhir_server_connection_cubit.dart';
import 'package:fire_scribe/auth/providers/bearer_token_provider.dart';
import 'package:fire_scribe/extensions/build_context.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BearerTokenProviderForm extends StatefulWidget {
  const BearerTokenProviderForm({super.key});

  @override
  State<BearerTokenProviderForm> createState() =>
      _BearerTokenProviderFormState();
}

class _BearerTokenProviderFormState extends State<BearerTokenProviderForm> {
  final serverUrlTextController = TextEditingController();
  final bearerTokenTextController = TextEditingController();
  var isConnecting = false;

  @override
  void initState() {
    super.initState();
    serverUrlTextController.text =
        BlocProvider.of<FhirServerConnectionCubit>(context).state.maybeWhen(
              authenticated: (_, client) => client.baseUrl.toString(),
              orElse: () => '',
            );

    BlocProvider.of<FhirServerConnectionCubit>(context)
        .accessToken()
        .then((value) {
      bearerTokenTextController.text = value ?? '';
    });
  }

  @override
  void dispose() {
    serverUrlTextController.dispose();
    bearerTokenTextController.dispose();
    super.dispose();
  }

  Future<void> connect() async {
    if (serverUrlTextController.text.isEmpty) {
      context.popAndPushSnackbar(
        message: S.of(context).serverUrlFormEmpty,
      );
      return;
    }
    if (bearerTokenTextController.text.isEmpty) {
      context.popAndPushSnackbar(
        message: S.of(context).bearerTokenFormEmpty,
      );
      return;
    }
    setState(() {
      isConnecting = true;
    });

    final isConnected =
        await BlocProvider.of<FhirServerConnectionCubit>(context).authenticate(
      url: serverUrlTextController.text,
      authProvider: BearerTokenAuthProvider(
        bearerToken: bearerTokenTextController.text,
      ),
    );

    if (!mounted) {
      return;
    }
    setState(() {
      isConnecting = false;
    });
    context.popAndPushSnackbar(
      message: isConnected
          ? S.of(context).serverConnectedWarning
          : S.of(context).serverNotConnectedWarning,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: serverUrlTextController,
          onSubmitted: (_) => connect(),
          decoration: InputDecoration(
            hintText: S.of(context).introduceServerUrl,
            labelText: S.of(context).serverUrl,
            hintStyle: Theme.of(context).textTheme.bodyLarge,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: bearerTokenTextController,
          onSubmitted: (_) => connect(),
          decoration: InputDecoration(
            hintText: S.of(context).introduceBearerToken,
            labelText: S.of(context).bearerToken,
            hintStyle: Theme.of(context).textTheme.bodyLarge,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
