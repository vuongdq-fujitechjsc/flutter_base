import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AppEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppLoggedIn extends AppEvent {
  final String token;

  AppLoggedIn({@required this.token});

  @override
  List<Object> get props => [token];
}

class AppLoggedOut extends AppEvent {}
