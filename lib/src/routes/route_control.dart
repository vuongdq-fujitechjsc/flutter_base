import 'package:fluro/fluro.dart' as Fluro;
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../account/account.dart';
import '../change_password/change_password.dart';
import '../home/home.dart';
import '../login/login.dart';
import '../main/main.dart';
import '../splash/splash.dart';
import '../webview/webview.dart';

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
        LoginScreen(mode: LoginViewMode.Login),
  );

  static Fluro.Handler _addAccountHandler = Fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        LoginScreen(mode: LoginViewMode.AddAccount),
  );

  static Fluro.Handler _mainHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          MainScreen());

  static Fluro.Handler _homeHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomeScreen());

  static Fluro.Handler _accountHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          AccountScreen());

  static Fluro.Handler _changePasswordHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          ChangePasswordScreen());

  static Fluro.Handler _webviewHandler = Fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          WebViewScreen());

  //setup
  static void configRouter() {
    router.define(RouterID.SPLASH, handler: _splashHandler);
    router.define(RouterID.LOGIN, handler: _loginHandler);
    router.define(
      RouterID.ADD_ACCOUNT,
      handler: _addAccountHandler,
      transitionType: Fluro.TransitionType.inFromRight,
    );
    router.define(RouterID.MAIN, handler: _mainHandler);
    router.define(RouterID.Home, handler: _homeHandler);
    router.define(
      RouterID.MULTI_ACCOUNT,
      handler: _accountHandler,
      transitionType: Fluro.TransitionType.inFromRight,
    );
    router.define(
      RouterID.CHANGE_PASSWORD,
      handler: _changePasswordHandler,
      transitionType: Fluro.TransitionType.inFromRight,
    );
    router.define(
      RouterID.WEBVIEW,
      handler: _webviewHandler,
      transitionType: Fluro.TransitionType.inFromRight,
    );
  }
}
