import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Hud extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  Hud({
    this.child,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: child,
      color: Colors.white,
      opacity: 0.2,
      inAsyncCall: isLoading,
    );
  }
}
