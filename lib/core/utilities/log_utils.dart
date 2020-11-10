class LogUtils {
  static bool _debug = true;
  static const String _tag = 'LogUtils';
  static void init({
    bool isDebug = false,
  }) {
    _debug = isDebug;
  }

  static debug(String msg, {String tag = _tag}) {
    if (_debug) {
      print('$tag-Debug, $msg');
    }
  }
}
