import 'package:fire_scribe/app.dart';
import 'package:fire_scribe/app_logger.dart';
import 'package:fire_scribe/auth/cubit/fhir_server_connection_cubit.dart';
import 'package:fire_scribe/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  Chain.capture(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await bootstrap();
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
    return BlocProvider<FhirServerConnectionCubit>(
      create: (_) => FhirServerConnectionCubit(
        talker: GetIt.instance<Talker>(),
      ),
      child: const App(),
    );
  }
}
