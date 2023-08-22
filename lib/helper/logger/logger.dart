/// A Logger For Flutter Apps
/// Usage:
/// 1) AppLog.i("Info Message");
/// 2) AppLog.i("Home Page", tag: "User Logging");
// ignore_for_file: constant_identifier_names

class AppLog {
  static const String _DEFAULT_TAG_PREFIX = "FlutterApp";

  ///use Log.v. Print all Logs
  static const int VERBOSE = 2;

  ///use Log.d. Print Debug Logs
  static const int DEBUG = 3;

  ///use Log.i. Print Info Logs
  static const int INFO = 4;

  ///use Log.w. Print warning logs
  static const int WARN = 5;

  ///use Log.e. Print error logs
  static const int ERROR = 6;

  ///use Log.wtf. Print Failure Logs(What a Terrible Failure= WTF)
  static const int WTF = 7;
// code color ANCI log
  static const int Black = 30;
  static const int Red = 31;
  static const int Green = 32;
  static const int Yellow = 33;
  static const int Blue = 34;
  static const int Magenta = 35;
  static const int Cyan = 36;
  static const int White = 37;
  static const int Default = 39;
  static const int Reset = 0;

  ///SET APP LOG LEVEL, Default ALL
  static int _currentLogLevel = VERBOSE;

  static setLogLevel(int priority) {
    int newPriority = priority;
    if (newPriority <= VERBOSE) {
      newPriority = VERBOSE;
    } else if (newPriority >= WTF) {
      newPriority = WTF;
    }
    _currentLogLevel = newPriority;
  }

  static int getLogLevel() {
    AppLog.i("Current Log Level is ${_getPriorityText(_currentLogLevel)}");
    return _currentLogLevel;
  }

  static _log(int priority, String tag, String message, String startColor) {
    if (_currentLogLevel <= priority) {
      // ignore: avoid_print
      print("$startColor${_getPriorityText(priority)}$tag: $message\x1B[0m");
    }
  }

  static String _getPriorityText(int priority) {
    switch (priority) {
      case INFO:
        return "INFO|";
      case DEBUG:
        return "DEBUG|";
      case ERROR:
        return "ERROR|";
      case WARN:
        return "WARN|";
      case WTF:
        return "WTF¯\\_(ツ)_/¯|";
      case VERBOSE:
      default:
        return "";
    }
  }

  ///Print general logs
  static v(String message, {String tag = _DEFAULT_TAG_PREFIX}) {
    _log(VERBOSE, tag, message, "\x1B[37m");
  }

  ///Print info logs
  static i(String message, {String tag = _DEFAULT_TAG_PREFIX}) {
    _log(INFO, tag, message, "\x1B[32m");
  }

  ///Print debug logs
  static d(String message, {String tag = _DEFAULT_TAG_PREFIX}) {
    _log(DEBUG, tag, message, "\x1B[92m");
  }

  ///Print warning logs
  static w(String message, {String tag = _DEFAULT_TAG_PREFIX}) {
    _log(WARN, tag, message, "\x1B[33m");
  }

  ///Print error logs
  static e(String message, {String tag = _DEFAULT_TAG_PREFIX}) {
    _log(ERROR, tag, message, "\x1B[31m");
  }

  ///Print failure logs
  static wtf(String message, {String tag = _DEFAULT_TAG_PREFIX}) {
    _log(WTF, tag, message, "\x1B[31m");
  }
}
