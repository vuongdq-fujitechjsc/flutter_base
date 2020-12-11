import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePasswordPressed extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordPressed(this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [this.oldPassword, this.newPassword];
}
