import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleMenuEvent extends MainEvent {}

class MainMenuSetStatus extends MainEvent {}
