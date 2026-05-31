import 'package:flutter/foundation.dart';

abstract class AppLogger {
  void error(String message, Object error, StackTrace stackTrace);
}

class DebugAppLogger implements AppLogger {
  const DebugAppLogger();

  @override
  void error(String message, Object error, StackTrace stackTrace) {
    debugPrint('$message: $error');
  }
}
