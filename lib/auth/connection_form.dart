import 'package:fire_scribe/auth/cubit/auth_cubit.dart';
import 'package:fire_scribe/auth/cubit/auth_provider_cubit.dart';
import 'package:fire_scribe/auth/providers/azure_identity_provider_cubit.dart';
import 'package:fire_scribe/extensions/build_context.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionForm extends StatefulWidget {
  const ConnectionForm({super.key});

  @override
  State<ConnectionForm> createState() => _ConnectionFormState();
}

class _ConnectionFormState extends State<ConnectionForm> {
  final textController = TextEditingController();
  var isConnecting = false;

  @override
  void initState() {
    super.initState();
    textController.text = BlocProvider.of<AuthCubit>(context)
        .provider<AzureIdentityProviderCubit>()
        .state
        .maybeWhen(
          authenticated: (data) => data,
          unauthenticated: () => '',
          orElse: () => '',
        );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> connect() async {
    setState(() {
      isConnecting = true;
    });
    final isConnected = await BlocProvider.of<AuthCubit>(context)
        .provider<AzureIdentityProviderCubit>()
        .signIn(
          AzureIdentityProviderCubitParams(
            serverUrl: textController.text,
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
    return BlocBuilder<AzureIdentityProviderCubit, AuthProviderState>(
      bloc: BlocProvider.of<AuthCubit>(context)
          .provider<AzureIdentityProviderCubit>(),
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
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
              ),
              SizedBox(width: 24),
              CircleAvatar(
                maxRadius: 8,
                backgroundColor: state.maybeWhen(
                  authenticated: (_) => Theme.of(context).colorScheme.primary,
                  unauthenticated: () => isConnecting
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                      : Theme.of(context).colorScheme.error,
                  orElse: () => Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
