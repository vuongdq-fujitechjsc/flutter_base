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
    student_id: json['student_id'] as int,
    student_name: json['student_name'] as String,
    access_token: json['access_token'] as String,
    refresh_token: json['refresh_token'] as String,
  );
}

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'student_id': instance.student_id,
      'student_name': instance.student_name,
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
    };
