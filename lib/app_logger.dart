import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppLogger {
  static AppLogger get instance => AppLogger._internal();
  factory AppLogger() => instance;

  final logger = TalkerLogger();

  AppLogger._internal();

  void e(final dynamic message,
      [final dynamic error, final StackTrace? stackTrace]) {
    final trace =
        stackTrace == null ? Chain.current(1) : Trace.from(stackTrace);
    logger.error(message);

    if (error != null) {
      logger.error(error);
    }

    logger.error(trace);
  }

  void i(final dynamic message,
      [final dynamic error, final StackTrace? stackTrace]) {
    logger.info(message);
  }

  void d(final dynamic message,
      [final dynamic error, final StackTrace? stackTrace]) {
    if (kDebugMode) {
      logger.debug(message);
    }
  }
}
