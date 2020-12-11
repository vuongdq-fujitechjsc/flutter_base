import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';

import 'change_password_event.dart';
import 'change_password_state.dart';
import 'change_password_bloc.dart';

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

class _ChangePasswordFormState
    extends BasePage<ChangePasswordForm, ChangePasswordBloc, AppBloc> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordControlelr = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  bool _isValidatedOldPassword = false;
  bool _isValidatedNewPassword = false;
  bool _isValidatedConfirmNewPassword = false;

  String _errorValidateOldPassword;
  String _errorValidateNewPassword;
  String _errorValidateConfirmNewPassword;

  bool _isInProgess = false;

  @override
  ChangePasswordBloc getBlocData(BuildContext context) => ChangePasswordBloc();

  @override
  void initState() {
    super.initState();
    LogUtils.debug('ChangePasswordScreen - initState');
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
        child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
          builder: (context, state) {
            return MyNavigation(
              navigationData: NavigationData(
                isShowNavigation: true,
                navigationLeftButtonType: NavigationLeftButtonType.iconBack,
                navigationTitle: multiLanguage.get('change_password_title'),
              ),
              bodyWidget: Hud(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        PasswordTextfieldWithTitle(
                          controller: _oldPasswordController,
                          hint:
                              multiLanguage.get('change_password_old_password'),
                          isSecureText: true,
                          errorText: _isValidatedOldPassword
                              ? null
                              : _errorValidateOldPassword,
                        ),
                        const SizedBox(height: 10.0),
                        PasswordTextfieldWithTitle(
                          controller: _newPasswordControlelr,
                          hint:
                              multiLanguage.get('change_password_new_password'),
                          isSecureText: true,
                          errorText: _isValidatedNewPassword
                              ? null
                              : _errorValidateNewPassword,
                        ),
                        const SizedBox(height: 10.0),
                        PasswordTextfieldWithTitle(
                          controller: _confirmNewPasswordController,
                          hint: multiLanguage
                              .get('change_password_confirm_new_password'),
                          isSecureText: true,
                          errorText: _isValidatedConfirmNewPassword
                              ? null
                              : _errorValidateConfirmNewPassword,
                        ),
                        const SizedBox(height: 30.0),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            elevation: 0,
                            color: HexColor(Color.COLOR_MAIN),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              multiLanguage.get('change_password_button'),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Dimension.textSize16,
                              ),
                            ),
                            onPressed: () {
                              String _oldPassword = _oldPasswordController.text;
                              String _newPassword = _newPasswordControlelr.text;
                              String _confirmNewPassword =
                                  _confirmNewPasswordController.text;

                              setState(() {
                                if (_oldPasswordController.text.isEmptyTrim()) {
                                  _isValidatedOldPassword = false;
                                  _errorValidateOldPassword =
                                      multiLanguage.get('MSG007');
                                } else if (!_oldPasswordController.text
                                    .isValidUsername()) {
                                  _isValidatedOldPassword = false;
                                  _errorValidateOldPassword =
                                      multiLanguage.get('MSG008');
                                } else {
                                  _isValidatedOldPassword = true;
                                }

                                if (_newPasswordControlelr.text.isEmptyTrim()) {
                                  _isValidatedNewPassword = false;
                                  _errorValidateNewPassword =
                                      multiLanguage.get('MSG009');
                                } else if (!_newPasswordControlelr.text
                                    .isValidPassword()) {
                                  _isValidatedNewPassword = false;
                                  _errorValidateNewPassword =
                                      multiLanguage.get('MSG010');
                                } else if (_oldPasswordController.text ==
                                    _newPasswordControlelr.text) {
                                  _isValidatedNewPassword = false;
                                  _errorValidateNewPassword =
                                      multiLanguage.get('MSG014');
                                } else {
                                  _isValidatedNewPassword = true;
                                }

                                if (_confirmNewPasswordController.text
                                    .isEmptyTrim()) {
                                  _isValidatedConfirmNewPassword = false;
                                  _errorValidateConfirmNewPassword =
                                      multiLanguage.get('MSG011');
                                } else if (!_confirmNewPasswordController.text
                                    .isValidPassword()) {
                                  _isValidatedConfirmNewPassword = false;
                                  _errorValidateConfirmNewPassword =
                                      multiLanguage.get('MSG012');
                                } else if (_newPasswordControlelr.text !=
                                    _confirmNewPasswordController.text) {
                                  _isValidatedConfirmNewPassword = false;
                                  _errorValidateConfirmNewPassword =
                                      multiLanguage.get('MSG013');
                                } else {
                                  _isValidatedConfirmNewPassword = true;
                                }
                              });

                              if (_isValidatedOldPassword &&
                                  _isValidatedNewPassword &&
                                  _isValidatedConfirmNewPassword) {
                                BlocProvider.of<ChangePasswordBloc>(context)
                                    .add(ChangePasswordPressed(
                                        _oldPassword, _confirmNewPassword));
                              }
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isLoading: _isInProgess,
              ),
            );
          },
          listener: (context, state) {
            _handleChangePasswordState(context, state);
          },
        ),
      )),
    );
  }

  _handleChangePasswordState(context, state) {
    _isInProgess = state is ChangePasswordInProgress;

    if (state is ChangePasswordSuccess) {
      showNotificationDialog(
        context: context,
        title: '',
        content: multiLanguage.get('MSG016'),
        doneAction: () => NavigationUtils.popToRoot(context),
      );
    } else if (state is ChangePasswordFailure) {
      showNotificationDialog(
        context: context,
        title: '',
        content: state.errorMessage,
      );
    }
  }
}
