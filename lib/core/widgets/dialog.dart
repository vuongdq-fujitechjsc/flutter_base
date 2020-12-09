import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../localizations/localizations.dart';
import '../utilities/utility.dart';

void showNotificationDialog({
  BuildContext context,
  String title,
  String content,
  Function doneAction,
  Function doneButtonTitle,
}) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: (title != null && title.length > 0)
          ? Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(
                title,
                style: TextStyle(
                    color: HexColor(Color.COLOR_TEXT_1),
                    fontSize: Dimension.textSize16,
                    fontWeight: FontWeight.bold),
              ),
            )
          : null,
      content: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        width: ScreenUtils.getInstance(context).width,
        child: Text(
          content,
          style: TextStyle(
            color: HexColor(Color.COLOR_TEXT_1),
            fontSize: Dimension.textSize13,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(doneButtonTitle ?? multiLanguage.get('ok_action')),
          onPressed: () => {
            if (doneAction != null) {doneAction()} else {Navigator.pop(context)}
          },
        )
      ],
    ),
  );
}
