import 'package:azure_identity/azure_identity.dart';
import 'package:fire_scribe/app.dart';
import 'package:fire_scribe/app_logger.dart';
import 'package:fire_scribe/auth/cubit/auth_cubit.dart';
import 'package:fire_scribe/auth/providers/azure_identity_provider_cubit.dart';
import 'package:fire_scribe/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  Chain.capture(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      await bootstrap();
      FlutterNativeSplash.remove();
      runApp(_Main());
    },
    onError: (error, chain) {
      AppLogger.instance.e(error);
    },
  );
}

class _Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(
        providers: {
          AzureIdentityProviderCubit(
            azureCredential: DefaultAzureCredential(
              logger: GetIt.instance<Talker>().debug,
            ),
          ),
        },
      ),
      child: const App(),
    );
  }
}
