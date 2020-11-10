import 'package:flutter/material.dart';

class ScreenUtils {
  static ScreenUtils _instance;

  static ScreenUtils getInstance(BuildContext context) {
    if (_instance == null) {
      _instance = ScreenUtils(context);
    }
    return _instance;
  }

  double _width = 0;
  double _height = 0;

  ScreenUtils(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
  }

  double get width => _width;
  double get height => _height;
}
