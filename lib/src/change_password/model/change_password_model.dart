import 'package:json_annotation/json_annotation.dart';

part 'change_password_model.g.dart';

@JsonSerializable()
class ChangePasswordModel {
  final int response_code;
  final String response_message;

  ChangePasswordModel({
    this.response_code,
    this.response_message,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordModelFromJson(json);

      Map<String, dynamic> toJson() => _$ChangePasswordModelToJson(this);
}