import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AccountForm();
  }
}

class AccountForm extends StatefulWidget {
  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: Column(children: [
            Container(
              child: Column(
                children: [
                  AuthenticateNavigation(isShowBackButton: true),
                  Center(
                    child: Text(
                      'Account Screen',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
      onWillPop: () => _onBackPressed(),
    );
  }

  Future<bool> _onBackPressed() => SystemNavigator.pop();
}
