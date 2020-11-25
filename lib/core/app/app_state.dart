import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppAuthenticationFailure extends AppState {}
