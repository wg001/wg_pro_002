import 'package:logger/logger.dart';

class LogUtils {
  static Logger _logger = Logger(
    printer: PrettyPrinter(
        methodCount: 0, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if an error is thrown
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: true // Should each log start with a timestamp
        ),
  );

  static void logInfo(String message) {
    _logger.i(message);
  }

  static void logDebug(String message) {
    _logger.d(message);
  }

  static void logWarning(String message) {
    _logger.w(message);
  }

  static void logError(String message, [Exception? error]) {
    _logger.e(message, error);
  }
}
