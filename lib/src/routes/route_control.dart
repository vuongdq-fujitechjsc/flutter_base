import 'package:fluro/fluro.dart' as Fluro;
import 'package:flutter/material.dart';

import '../account/account.dart';
import '../home/home.dart';
import '../login/login.dart';
import '../main/main.dart';
import '../splash/splash.dart';

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

  static Fluro.Handler _mainHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          MainScreen());

  static Fluro.Handler _homeHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomeScreen());

  static Fluro.Handler _accountHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          AccountScreen());

  //setup
  static void configRouter() {
    router.define(RouterID.SPLASH, handler: _splashHandler);
    router.define(RouterID.LOGIN, handler: _loginHandler);
    router.define(RouterID.MAIN, handler: _mainHandler);
    router.define(RouterID.Home, handler: _homeHandler);
    router.define(RouterID.MULTI_ACCOUNT,
        handler: _accountHandler,
        transitionType: Fluro.TransitionType.inFromRight);
  }
}
