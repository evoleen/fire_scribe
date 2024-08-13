import 'package:auth_cubit/auth_cubit.dart';
import 'package:auth_cubit_biometrics/auth_cubit_biometrics.dart';
import 'package:auth_cubit_firebase/auth_cubit_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fastapp/app.dart';
import 'package:flutter_fastapp/bootstrap.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
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
  );
}

class _Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        providers: {
          BiometricsAuthCubitProvider(
            sharedPreferences: GetIt.instance(),
            localAuthentication: LocalAuthentication(),
          ),
          FirebaseEmailPasswordAuthCubitProvider(
            firebaseAuth: firebase_auth.FirebaseAuth.instance,
          ),
        },
      ),
      child: App(),
    );
  }
}
