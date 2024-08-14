import 'package:firearrow_admin_app/app_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> bootstrap() async {
  final talker = TalkerFlutter.init(
    logger: AppLogger.instance.logger,
  );
  Bloc.observer = TalkerBlocObserver(talker: talker);

  GoRouter.optionURLReflectsImperativeAPIs = true;

  GetIt.instance.registerSingleton(GlobalKey<NavigatorState>());
  GetIt.instance.registerSingleton(await SharedPreferences.getInstance());
}
