import 'package:flutter/material.dart';

class NavigationUtils {
  static void popToRoot(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
