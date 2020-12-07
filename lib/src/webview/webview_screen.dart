import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';

class WebViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebViewForm();
  }
}

class WebViewForm extends StatefulWidget {
  @override
  _WebViewFormState createState() => _WebViewFormState();
}

class _WebViewFormState extends State<WebViewForm> {
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
                      'WebView Screen',
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
