// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) {
  return LoginModel(
    response_code: json['response_code'] as int,
    response_message: json['response_message'] as String,
    data: json['data'] == null
        ? null
        : LoginData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'response_code': instance.response_code,
      'response_message': instance.response_message,
      'data': instance.data,
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) {
  return LoginData(
    access_token: json['access_token'] as String,
    refresh_token: json['refresh_token'] as String,
    student_id: json['student_id'] as int,
    student_name: json['student_name'] as String,
    account_name: json['account_name'] as String,
    account_password: json['account_password'] as String,
    is_default_password: json['is_default_password'] as int,
  );
}

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
      'student_id': instance.student_id,
      'student_name': instance.student_name,
      'account_name': instance.account_name,
      'account_password': instance.account_password,
      'is_default_password': instance.is_default_password,
    };
