import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static Future<T> get<T>(String key, T defaultValue) async {
    var _prefs = await SharedPreferences.getInstance();

    try {
      T value = _prefs.get(key);
      if (value == null) {
        return defaultValue;
      }
      return value;
    } catch (error) {
      return defaultValue;
    }
  }

  static Future<bool> putInt(String key, int value) async {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.setInt(key, value);
  }

  static Future<bool> putString(String key, String value) async {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.setString(key, value);
  }

  static Future<bool> putDouble(String key, double value) async {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.setDouble(key, value);
  }

  static Future<bool> putBool(String key, bool value) async {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.setBool(key, value);
  }

  static Future<bool> putListString(String key, List<String> value) async {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.setStringList(key, value);
  }

  static Future<bool> clear(String key) async {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.remove(key);
  }

  static Future<bool> clearAll() async {
    var _prefs = await SharedPreferences.getInstance();
    final result = await _prefs.clear();
    return result;
  }
}
