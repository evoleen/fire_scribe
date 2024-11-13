import 'package:fire_scribe/auth/auth_cubit/auth_cubit.dart';
import 'package:fire_scribe/auth/providers/bearer_token_provider.dart';
import 'package:fire_scribe/extensions/build_context.dart';
import 'package:fire_scribe/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UrlTokenConnectionForm extends StatefulWidget {
  const UrlTokenConnectionForm({super.key});

  @override
  State<UrlTokenConnectionForm> createState() => _UrlTokenConnectionFormState();
}

class _UrlTokenConnectionFormState extends State<UrlTokenConnectionForm> {
  final textController = TextEditingController();
  final tokenTextController = TextEditingController();
  var isConnecting = false;

  @override
  void initState() {
    super.initState();
    textController.text = BlocProvider.of<AuthCubit>(context).state.maybeWhen(
          authenticated: (url, _) => url,
          orElse: () => '',
        );

    BlocProvider.of<AuthCubit>(context)
        .provider<BearerTokenAuthProvider>()
        ?.accessToken()
        .then((value) {
      tokenTextController.text = value ?? '';
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> connect() async {
    if (textController.text.isEmpty) {
      context.popAndPushSnackbar(
          message: 'Please, add a servel url to connect');
      return;
    }
    if (tokenTextController.text.isEmpty) {
      context.popAndPushSnackbar(
          message: 'Please, add a Bearer token to connect');
      return;
    }
    setState(() {
      isConnecting = true;
    });

    final isConnected = await BlocProvider.of<AuthCubit>(context).connect(
      url: textController.text,
      authProvider: BearerTokenAuthProvider(
        bearerToken: tokenTextController.text,
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
        Row(
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
          ],
        ),
        SizedBox(height: 16),
        TextField(
          controller: tokenTextController,
          onSubmitted: (_) => connect(),
          decoration: InputDecoration(
            hintText: 'Introduce Bearer token',
            labelText: 'Bearer token',
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
