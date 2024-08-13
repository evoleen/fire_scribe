import 'dart:developer' as developer;

import 'package:stack_trace/stack_trace.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppLogger {
  static AppLogger get instance => AppLogger._internal();
  factory AppLogger() => instance;

  final logger = TalkerLogger(
    output: (message) => developer.log(message),
  );

  AppLogger._internal();

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    final trace =
        stackTrace == null ? Chain.current(1) : Trace.from(stackTrace);

    logger.error(message);

    if (error != null) {
      logger.error(error);
    }

    logger.error(trace);
  }

  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.info(message);
  }

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.debug(message);
  }
}
