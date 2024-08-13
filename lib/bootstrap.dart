import 'package:firearrow_admin_app/app_logger.dart';
import 'package:firearrow_admin_app/clock/app_clock.dart';
import 'package:firearrow_admin_app/environment.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_machine/time_machine.dart';

Future<void> bootstrap() async {
  await Environment.init();
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  await TimeMachine.initialize({
    'rootBundle': rootBundle,
  });

  Bloc.observer = TalkerBlocObserver(
    talker: TalkerFlutter.init(
      logger: AppLogger.instance.logger,
    ),
  );

  GetIt.instance.registerSingleton(() => GlobalKey<NavigatorState>());
  GetIt.instance.registerFactoryAsync(() => SharedPreferences.getInstance());
  GetIt.instance.registerLazySingleton<Clock>(() => AppClock.instance);
}
