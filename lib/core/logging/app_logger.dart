import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

class AppLogger {
  static LogLevel minLevel = kDebugMode ? LogLevel.debug : LogLevel.info;

  static void log(
    LogLevel level,
    String subsystem,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (level.index < minLevel.index) return;

    final timestamp = DateTime.now().toIso8601String();
    final prefix = '[${level.name.toUpperCase()}][$subsystem][$timestamp]';
    final output = '$prefix $message';

    if (level == LogLevel.error) {
      debugPrint('\x1B[31m$output\x1B[0m');
      if (error != null) debugPrint('\x1B[31mError: $error\x1B[0m');
      if (stackTrace != null) debugPrint('\x1B[31m$stackTrace\x1B[0m');
    } else if (level == LogLevel.warning) {
      debugPrint('\x1B[33m$output\x1B[0m');
    } else {
      debugPrint(output);
    }
  }

  static void debug(String subsystem, String message) =>
      log(LogLevel.debug, subsystem, message);

  static void info(String subsystem, String message) =>
      log(LogLevel.info, subsystem, message);

  static void warning(String subsystem, String message, {Object? error}) =>
      log(LogLevel.warning, subsystem, message, error: error);

  static void error(
    String subsystem,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) =>
      log(LogLevel.error, subsystem, message, error: error, stackTrace: stackTrace);
}
