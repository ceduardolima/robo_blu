import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {
  final Logger _logger;
  static Log? _instance;

  Log._(this._logger);

  static Log get instance {
    if (_instance == null) {
      return Log._(
        Logger(
          printer: PrettyPrinter(
            printEmojis: false,
          ),
        ),
      );
    }
    return _instance!;
  }

  static void i(dynamic message,
      {DateTime? time,
      Object? error,
      StackTrace? stackTrace,
      }) {
    instance._logger.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message,
      {DateTime? time,
      Object? error,
      StackTrace? stackTrace,
      }) {
    instance._logger.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void e(dynamic message,
      {DateTime? time,
      Object? error,
      StackTrace? stackTrace,
      }) {
    instance._logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void d(dynamic message,
      {DateTime? time,
      Object? error,
      StackTrace? stackTrace,
      }) {
    instance._logger.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void f(dynamic message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    instance._logger.f(message, time: time, error: error, stackTrace: stackTrace);
  }
}

class AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (kDebugMode) {
      return true;
    } else {
      if (event.level == Level.error ||
          event.level == Level.fatal ||
          event.level == Level.warning) {
        return true;
      }
      return false;
    }
  }
}
