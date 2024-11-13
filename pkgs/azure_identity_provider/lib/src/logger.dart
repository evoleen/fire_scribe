import 'dart:developer' as developer;

import 'package:stack_trace/stack_trace.dart';
import 'package:talker/talker.dart';

class Logger {
  static Logger get instance => Logger._internal();
  factory Logger() => instance;

  final logger = TalkerLogger(
    output: (message) => developer.log(message),
  );

  Logger._internal();

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
    logger.debug(message);
  }
}
