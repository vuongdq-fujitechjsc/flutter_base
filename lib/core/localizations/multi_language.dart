import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiLanguageBloc {
  final _controller = StreamController<dynamic>.broadcast();

  Function(dynamic) get push => _controller.sink.add;
  Stream<dynamic> get stream => _controller.stream;

  var counter = 0;

  MultiLanguageBloc();

  changeLanguage({context, String path}) {
    MultiLanguage.setLanguage(
      path: path,
      context: context,
    );
    push(null);
  }

  changeLanguageTest(context) {
    MultiLanguage.setLanguage(
      path: counter % 2 == 0 ? Languages.en : Languages.ja,
      context: context,
    );
    counter++;
    push(null);
  }

  void dispose() {
    _controller.close();
  }
}

MultiLanguageBloc multiLanguageBloc = MultiLanguageBloc();

class Languages {
  Languages._();
  static const String en = 'assets/locale/localization_en.json';
  static const String ja = 'assets/locale/localization_ja.json';
}

String _languageKey = 'lang';

Map<String, String> _languageSupport = {
  'en': Languages.en,
  'ja': Languages.ja,
};

class MultiLanguage {
  static const MethodChannel _channel =
      const MethodChannel('multilanguage_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  final english = 'assets/locale/localization_en.json';
  Map<String, dynamic> phrases;
  MultiLanguage(this.phrases);

  static setLanguageDevice({
    @required String defaultPath,
    @required BuildContext context,
    Function() onLoad,
    bool start = false,
  }) async {
    Locale myLocale = Localizations.localeOf(
      context,
      nullOk: true,
    );

    if (myLocale != null &&
        _languageSupport.containsKey(myLocale.languageCode)) {
      var file = await DefaultAssetBundle.of(context)
          .loadString(_languageSupport[myLocale.languageCode]);
      multiLanguage = MultiLanguage(jsonDecode(file));
    } else {
      var file = await DefaultAssetBundle.of(context).loadString(defaultPath);
      multiLanguage = MultiLanguage(jsonDecode(file));
    }
  }

  static setLanguage({
    @required String path,
    @required BuildContext context,
    Function() onLoad,
    bool start = false,
  }) async {
    // final prefs = await SharedPreferences.getInstance();
    // //if save current language to sharedPreferences
    // if (prefs.getString(_langKey) != null && start)
    //   path = prefs.getString(_langKey);

    var file = await DefaultAssetBundle.of(context).loadString(path);
    multiLanguage = MultiLanguage(jsonDecode(file));

    //prefs.setString(_languageKey, path);
  }

  String get(String key) {
    return phrases != null ? phrases[key] : "";
  }
}

MultiLanguage multiLanguage = MultiLanguage(null);
