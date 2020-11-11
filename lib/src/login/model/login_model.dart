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
  final int student_id;
  final String student_name;
  final String access_token;
  final String refresh_token;

  LoginData({
    this.student_id,
    this.student_name,
    this.access_token,
    this.refresh_token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return _$LoginDataFromJson(json);
  }
}
