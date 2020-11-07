import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimamu/3.%20Utilities/log_util.dart';
import 'package:mimamu/5.%20UI/Login/login_bloc.dart';
import 'package:mimamu/5.%20UI/Login/login_event.dart';
import 'package:mimamu/5.%20UI/Login/login_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    LogUtil.debug('LoginScreen - initState');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
            create: (context) {
              return LoginBloc("ff");
            },
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                LogUtil.debug('LoginScreen, listener {state: $state}');
                if (state is LoginSuccess) {
                  LogUtil.info('Login Success !');
                  return;
                }
                if (state is LoginFailure) {
                  LogUtil.info('Login Failure !');
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  LogUtil.debug('LoginScreen: BlocBuilder {state: $state}');

                  return SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 20),
                            //icon
                            Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/ic_login.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            //username textfield
                            makeTextField(
                              _usernameController,
                              placeHolderText: "ログインID",
                              obsecureText: false,
                            ),
                            //password textfield
                            makeTextField(
                              _passwordController,
                              placeHolderText: "パスワード",
                              obsecureText: true,
                            ),
                            //checkbox save
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (bool newValueCheck) {
                                      // setState(() {
                                      //   print('Current value of checkbox is: ');
                                      // });
                                    },
                                  ),
                                  Text(
                                    'パスワードを保存する',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            //button login
                            Container(
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
                                onPressed: () {
                                  print("Tapped");
                                  // if (state is LoginInProgress) {
                                  //   return;
                                  // }

                                  String _username = _usernameController.text;
                                  String _password = _passwordController.text;

                                  BlocProvider.of<LoginBloc>(context)
                                      .add(LoginPressed(_username, _password));
                                },
                                textColor: Colors.white,
                                padding: const EdgeInsets.all(16.0),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    content: new Text(
                                        "「パスワード」を忘れたときは通塾されている教室へお問い合わせをお願いします。"),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        isDefaultAction: true,
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text(
                                'パスワードを忘れた場合',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            GestureDetector(
                              onTap: () {
                                print('Open to Multi Account view');
                              },
                              child: Text(
                                '別のアカウントを使用',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ),
                          ]),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}

Widget makeTextField(
  TextEditingController tfController, {
  placeHolderText,
  obsecureText = false,
  maxLength,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
    child: TextField(
      obscureText: obsecureText,
      minLines: 1,
      controller: tfController,
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
        hintText: placeHolderText,
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
