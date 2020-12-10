import 'package:equatable/equatable.dart';

abstract class WebviewState extends Equatable {
  const WebviewState();

  @override
  List<Object> get props => [];
}

class WebviewInitial extends WebviewState {}
