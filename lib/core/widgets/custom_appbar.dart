import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final Widget trailing;
  final Color backgroundColor;
  final void Function() onTabTrailing;

  CustomAppBar({
    this.title,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.onTabTrailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      automaticallyImplyLeading: false,
      leading: leading,
      title: title,
      backgroundColor: backgroundColor,
      elevation: 0,
      titleSpacing: 0,
      centerTitle: true,
      actions: <Widget>[trailing],
    );
  }
}
