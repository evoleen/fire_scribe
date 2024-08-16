import 'package:auth_cubit/auth_cubit.dart';
import 'package:firearrow_admin_app/app.dart';
import 'package:firearrow_admin_app/app_logger.dart';
import 'package:firearrow_admin_app/auth/cubit/azure_identify_provider_cubit.dart';
import 'package:firearrow_admin_app/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:stack_trace/stack_trace.dart';

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
          AzureIdentifyProviderCubit(),
        },
      ),
      child: const App(),
    );
  }
}
