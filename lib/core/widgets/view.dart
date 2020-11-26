import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mimamu/core/core.dart';

import '../localizations/localizations.dart';

class InputDoneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      height: 35,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 0.0,
            bottom: 0.0,
          ),
          child: CupertinoButton(
            padding: EdgeInsets.only(
              right: 10.0,
              top: 0.0,
              bottom: 0.0,
            ),
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Text(
              multiLanguage.get("done_action"),
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuSelectItemRow extends StatelessWidget {
  final String title;
  final void Function() onTap;

  MenuSelectItemRow({
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.0,
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor(Color.COLOR_TEXT_SIDE_MENU),
                fontSize: Dimension.textSize14,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
