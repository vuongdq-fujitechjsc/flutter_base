import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordInProgress extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordFailure extends ChangePasswordState {
  final String errorMessage;
  const ChangePasswordFailure({@required this.errorMessage});

  @override
  List<Object> get props => [this.errorMessage];
}
