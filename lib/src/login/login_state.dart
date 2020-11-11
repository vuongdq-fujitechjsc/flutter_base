import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginValidate extends LoginState {
  final String title;
  final String content;

  LoginValidate({this.title, this.content});

  @override
  List<Object> get props => [this.title, this.content];
}

class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure({@required this.errorMessage});

  @override
  List<Object> get props => [this.errorMessage];
}
