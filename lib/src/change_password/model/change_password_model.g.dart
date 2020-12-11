// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordModel _$ChangePasswordModelFromJson(Map<String, dynamic> json) {
  return ChangePasswordModel(
    response_code: json['response_code'] as int,
    response_message: json['response_message'] as String,
  );
}

Map<String, dynamic> _$ChangePasswordModelToJson(
        ChangePasswordModel instance) =>
    <String, dynamic>{
      'response_code': instance.response_code,
      'response_message': instance.response_message,
    };
