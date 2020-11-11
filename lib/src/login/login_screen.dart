import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../home/home.dart';
import '../routes/router.dart';

import 'login_event.dart';
import 'login_state.dart';
import 'login_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginForm();
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends BasePage<LoginForm, LoginBloc, AppBloc> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isInProgress = false;
  bool _isSaveAccount = false;

  @override
  LoginBloc getBlocData(BuildContext context) => LoginBloc();

  @override
  void initState() {
    super.initState();
    LogUtils.debug('LoginScreen - initState');
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismiss(
      gestures: [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        body: BlocProvider(
            create: (context) {
              return this.bloc;
            },
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                _handleState(context, state);
              },
              builder: (context, state) {
                return SafeArea(
                  child: Hud(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(height: 20),
                              //icon
                              Container(
                                width: 170,
                                height: 170,
                                child: Image.asset(AssetUtils.instance()
                                    .getImageUrl("ic_login.png")),
                              ),
                              //username textfield
                              TextfieldWithTitle(
                                controller: _usernameController,
                                hint: multiLanguage.get('login_username_title'),
                              ),
                              //password textfield
                              PasswordTextfieldWithTitle(
                                controller: _passwordController,
                                hint: multiLanguage.get('login_password_title'),
                                isSecureText: true,
                              ),
                              const SizedBox(height: 10.0),
                              //checkbox save
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: _isSaveAccount,
                                    onChanged: _checkboxChanged,
                                  ),
                                  Text(
                                    multiLanguage.get('login_save_title'),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              //button login
                              Container(
                                width: double.infinity,
                                child: RaisedButton(
                                  elevation: 0,
                                  color: HexColor(Color.COLOR_MAIN),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    multiLanguage.get('login_login_button'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimension.textSize16,
                                    ),
                                  ),
                                  onPressed: () {
                                    String _username = _usernameController.text;
                                    String _password = _passwordController.text;

                                    BlocProvider.of<LoginBloc>(context).add(
                                        LoginPressed(_username, _password));
                                  },
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.all(16.0),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              //label forgot password
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                      content: new Text(multiLanguage
                                          .get('login_forgot_password_dialog')),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          isDefaultAction: true,
                                          child: Text(
                                              multiLanguage.get('ok_action')),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text(
                                  multiLanguage
                                      .get('login_forgot_password_title'),
                                  style: TextStyle(
                                    fontSize: Dimension.textSize14,
                                    color: HexColor(Color.COLOR_TEXT_MAIN),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              //label multi password
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, RouterID.MULTI_ACCOUNT),
                                child: Text(
                                  multiLanguage
                                      .get('login_multi_account_title'),
                                  style: TextStyle(
                                    fontSize: Dimension.textSize14,
                                    color: HexColor(Color.COLOR_TEXT_MAIN),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    isLoading: _isInProgress,
                  ),
                );
              },
            )),
      ),
    );
  }

  //handle state
  void _handleState(context, state) {
    _isInProgress = state is LoginInProgress;

    if (state is LoginSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } else if (state is LoginValidate) {
      showNotificationDialog(
        context: context,
        title: state.title,
        content: state.content,
      );
    } else if (state is LoginFailure) {
      showNotificationDialog(
        context: context,
        title: "",
        content: state.errorMessage,
      );
    }
  }

  //handle checkbox
  void _checkboxChanged(bool newValue) => setState(() {
        LogUtils.debug('Call me - currentValue is: $_isSaveAccount');
        _isSaveAccount = newValue;
        LogUtils.debug('Call me - newValue is: $_isSaveAccount');
      });
}
