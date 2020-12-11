import 'dart:async';
import 'dart:convert';

import '../../core/core.dart';

import 'model/change_password_model.dart';

class ChangePasswordRepository {
  Future<dynamic> changePassword(String oldPassword, String newPassword) {
    var completer = new Completer();

    var map = Map<String, dynamic>();
    map['old_password'] = oldPassword;
    map['new_password'] = newPassword;

    HttpClient.getInstance().patch(
      ConstantsCore.API_CHANGE_PASSWORD,
      body: json.encode(map),
      onCompleted: (json) async {
        var response = ChangePasswordModel.fromJson(json);

        var responseCode = response.response_code;

        if (responseCode == 200) {
          //change password success
          completer.complete(true);
        } else if (responseCode == 400) {
          //old password is wrong
          completer.complete(false);
        }else{
          completer.complete(false);
        }
      },
      onFailed: (error) {
        completer.complete(error.errorMessage);
      },
    );

    return completer.future;
  }
}
