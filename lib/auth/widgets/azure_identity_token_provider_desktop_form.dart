import 'package:azure_identity/azure_identity.dart';
import 'package:fire_scribe/app_logger.dart';
import 'package:fire_scribe/auth/cubit/fhir_server_connection_cubit.dart';
import 'package:fire_scribe/auth/providers/azure_identity_token_provider_desktop.dart';
import 'package:fire_scribe/extensions/build_context.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AzureIdentityTokenProviderForm extends StatefulWidget {
  const AzureIdentityTokenProviderForm({super.key});

  @override
  State<AzureIdentityTokenProviderForm> createState() =>
      _AzureIdentityTokenProviderFormState();
}

class _AzureIdentityTokenProviderFormState
    extends State<AzureIdentityTokenProviderForm> {
  final serverUrlTextController = TextEditingController();
  var isConnecting = false;

  @override
  void initState() {
    super.initState();
    serverUrlTextController.text =
        BlocProvider.of<FhirServerConnectionCubit>(context).state.maybeWhen(
              authenticated: (provider, client) => client.baseUrl.toString(),
              orElse: () => '',
            );
  }

  @override
  void dispose() {
    serverUrlTextController.dispose();
    super.dispose();
  }

  Future<void> connect() async {
    if (serverUrlTextController.text.isEmpty) {
      context.popAndPushSnackbar(
        message: S.of(context).serverUrlFormEmpty,
      );
      return;
    }

    setState(() {
      isConnecting = true;
    });
    final isConnected =
        await BlocProvider.of<FhirServerConnectionCubit>(context).authenticate(
      url: serverUrlTextController.text,
      authProvider: AzureIdentityTokenProviderDesktop(
        url: serverUrlTextController.text,
        tokenCredential: DefaultAzureCredential(
          logger: AppLogger.instance.d,
        ),
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
    return TextField(
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
    );
  }
}
