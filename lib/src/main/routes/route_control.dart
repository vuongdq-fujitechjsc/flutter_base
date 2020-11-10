import 'package:fluro/fluro.dart' as Fluro;
import 'package:flutter/material.dart';

import 'router_id.dart';
import '../../splash/splash.dart';

class FluroRouter {
  static Fluro.FluroRouter router = Fluro.FluroRouter();
  static RouteSettings settings = RouteSettings();

  //handler
  static Fluro.Handler _splashHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SplashScreen());

  //setup
  static void configRouter() {
    router.define(RouterID.SPLASH, handler: _splashHandler);
  }
}
