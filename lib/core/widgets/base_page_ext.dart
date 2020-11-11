import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BasePageExt {
  B findBloc<B extends Bloc>(BuildContext context) {
    return BlocProvider.of<B>(context);
  }
}
