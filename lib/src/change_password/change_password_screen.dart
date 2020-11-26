import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangePasswordForm();
  }
}

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
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
                      'Change Password Screen',
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
