import 'package:fluro/fluro.dart' as Fluro;
import 'package:flutter/material.dart';

import '../splash/splash.dart';
import '../login/login.dart';
import '../home/home.dart';

import 'router_id.dart';

class FluroRouter {
  static Fluro.FluroRouter router = Fluro.FluroRouter();
  static RouteSettings settings = RouteSettings();

  //handler
  static Fluro.Handler _splashHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SplashScreen());

  static Fluro.Handler _loginHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          LoginScreen());

  static Fluro.Handler _homeHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomeScreen());

  //setup
  static void configRouter() {
    router.define(RouterID.SPLASH, handler: _splashHandler);
    router.define(RouterID.LOGIN, handler: _loginHandler);
    router.define(RouterID.MAIN, handler: _homeHandler);
  }
}
