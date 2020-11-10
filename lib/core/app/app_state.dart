import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppAuthenticationFailure extends AppState {}
