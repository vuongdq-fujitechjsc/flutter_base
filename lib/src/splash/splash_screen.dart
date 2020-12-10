import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mimamu/src/login/login.dart';
import 'package:mimamu/src/main/main.dart';

import '../../core/core.dart';
import '../routes/router.dart';
import '../login/model/login_model.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // DBProvider.db.deleteDB();
    DBProvider.db.getAllUser();

    HttpClient.getInstance().checkInternetConnection().then((value) {
      if (value) {
        _checkToken().then((isLogined) async {
          if (isLogined) {
            //update account service

            //push to main
            // Navigator.pushNamed(context, RouterID.MAIN);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                (Route<dynamic> route) => false);
            //       Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => MainScreen()),
            //   (Route<dynamic> route) => false,
            // );
          } else {
            //push to login
            // Navigator.pushNamed(context, RouterID.LOGIN);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false);
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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Text(
              'Splash Screen',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _checkToken() async {
    var completer = new Completer();
    SharedPreferencesManager.get(ConstantsCore.STORAGE_ACCOUNT_ACTIVE, "")
        .then((account) async {
      LoginData activeAccount = await DBProvider.db.getUser(account);
      final loginState = await SharedPreferencesManager.get<bool>(
          ConstantsCore.STORAGE_IS_LOGIN, false);

      if ((activeAccount.access_token.length > 0) && loginState) {
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
