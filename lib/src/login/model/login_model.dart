import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  final int response_code;
  final String response_message;
  final LoginData data;

  LoginModel({
    this.response_code,
    this.response_message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
}

@JsonSerializable()
class LoginData {
  String access_token;
  String refresh_token;
  final int student_id;
  final String student_name;
  String account_name;
  String account_password;
  int is_default_password;

  LoginData({
    this.access_token,
    this.refresh_token,
    this.student_id,
    this.student_name,
    this.account_name,
    this.account_password,
    this.is_default_password,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return _$LoginDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
