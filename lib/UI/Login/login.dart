import 'package:flutter/material.dart';

class LoginEightPage extends StatelessWidget {
  static final String path = "lib/src/pages/login/login8.dart";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  IconLogin(),
                  TfUsername(),
                  TfPassword(),
                  CbSave(),
                  BtnLogin(),
                  LblForgotPassword(),
                  LblMultiAccount(),
                ]),
          ),
        ),
      ),
    );
  }
}

class CbSave extends StatefulWidget {
  const CbSave({
    Key key,
  }) : super(key: key);

  @override
  _CbSaveState createState() => _CbSaveState();
}

class _CbSaveState extends State<CbSave> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (bool newValueCheck) {
              setState(() {
                print('Current value of checkbox is: ');
              });
            },
          ),
          Text(
            'パスワードを保存する',
            style: TextStyle(fontSize: 15, color: Colors.black),
          )
        ],
      ),
    );
  }
}

class LblMultiAccount extends StatelessWidget {
  const LblMultiAccount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: GestureDetector(
        onTap: () {
          print('Open to Multi Account view');
        },
        child: Text(
          '別のアカウントを使用',
          style: TextStyle(fontSize: 15, color: Colors.blue),
        ),
      ),
    );
  }
}

class LblForgotPassword extends StatelessWidget {
  const LblForgotPassword({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: GestureDetector(
        onTap: () {
          print('Open to Forgot password view');
        },
        child: Text(
          'パスワードを忘れた場合',
          style: TextStyle(fontSize: 15, color: Colors.blue),
        ),
      ),
    );
  }
}

class BtnLogin extends StatelessWidget {
  const BtnLogin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: RaisedButton(
        elevation: 0,
        color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          "ログイン",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
        onPressed: () {},
        textColor: Colors.white,
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }
}

class TfPassword extends StatelessWidget {
  const TfPassword({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.black45),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: "パスワード",
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
          // errorText: "Error Text",
          // errorStyle: TextStyle(fontSize: 14.0),
        ),
      ),
    );
  }
}

class TfUsername extends StatelessWidget {
  const TfUsername({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextField(
          decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.black45),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45),
          borderRadius: BorderRadius.circular(5.0),
        ),
        hintText: "ログインID",
        hintStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 16.0,
        ),
        // errorText: "ErrorXtyle(fontSize: 14.0),
      )),
    );
  }
}

class IconLogin extends StatelessWidget {
  const IconLogin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 170,
        height: 170,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ic_login.png'),
            fit: BoxFit.cover,
          ),
        ));
  }
}
