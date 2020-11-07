class LogUtil {
  static bool _debug = true;
  static const String _tag = 'LogUtil';
  static void init({
    bool isDebug = false,
  }) {
    _debug = isDebug;
  }

  static error(String msg, {String tag = _tag}) {
    if (_debug) {
      print('$tag-Error, $msg');
    }
  }

  static debug(String msg, {String tag = _tag}) {
    if (_debug) {
      print('$tag-Debug, $msg');
    }
  }

  static info(String msg, {String tag = _tag}) {
    if (_debug) {
      print('$tag-Info, $msg');
    }
  }
}
