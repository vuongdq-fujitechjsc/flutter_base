import 'dart:async';
import 'dart:convert';

import '../../core/core.dart';

import 'model/login_model.dart';

class LoginRepository {
  Future<dynamic> login(String username, String password) {
    var completer = new Completer();

    var map = Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;
    map['device_type'] = 1; //0:AOS, 1:IOS
    map['device_token'] = 'device_token_test';

    HttpClient.getInstance().post(
      ConstantsCore.API_GET_TOKEN,
      body: json.encode(map),
      onCompleted: (json) async {
        var response = LoginModel.fromJson(json);
        final token = response.data.access_token;

        if (token != null) {
          //save login state
          SharedPreferencesManager.putBool(
              ConstantsCore.STORAGE_IS_LOGIN, true);

          //delete user if duplicate in database
          await DBProvider.db.deleteUser(response.data);

          //change account info
          response.data.account_name = username;
          response.data.account_password = password;

          //save account to database
          await DBProvider.db.createUser(response.data);

          //save active account
          await SharedPreferencesManager.putString(
              ConstantsCore.STORAGE_ACCOUNT_ACTIVE, response.data.account_name);

          //setting notification
        }

        completer.complete(null);
      },
      onFailed: (error) {
        completer.complete(error.errorMessage);
      },
    );

    return completer.future;
  }
}
