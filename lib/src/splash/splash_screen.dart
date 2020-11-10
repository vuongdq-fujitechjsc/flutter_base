import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../routes/router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    HttpClient.getInstance().checkInternetConnection().then((value) {
      if (value) {
        _checkToken().then((isLogined) async {
          if (isLogined) {
            //update account service
            
            //push to main
            Navigator.pushReplacementNamed(context, RouterID.MAIN);
          } else {
            //push to login
            Navigator.pushReplacementNamed(context, RouterID.LOGIN);
          }
        });
      } else {
        showNotificationDialog(
          context: context,
          content: multiLanguage.get('message_api_error'),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          'Demo',
          style: TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Future<dynamic> _checkToken() async {
    var completer = new Completer();
    SharedPreferencesManager.get(ConstantsCore.ACCESS_TOKEN, "").then((token) {
      if (token.length > 0) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    }).catchError((error) {
      completer.complete(false);
    });
    return completer.future;
  }
}
