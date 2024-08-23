import 'package:auth_cubit/auth_cubit.dart';
import 'package:firearrow_admin_app/auth/cubit/azure_identify_provider_cubit.dart';
import 'package:firearrow_admin_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: TextField(
        controller: textController,
        onSubmitted: (text) {
          BlocProvider.of<AuthCubit>(context)
              .provider<AzureIdentityProviderCubit>()
              .signIn(
                AzureIdentityProviderCubitParams(
                  serverUrl: text,
                ),
              );
        },
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
    );
  }
}
