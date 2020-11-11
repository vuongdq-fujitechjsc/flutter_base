import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../utilities/utility.dart';

class AuthenticateNavigation extends StatelessWidget {
  final bool isShowBackButton;

  AuthenticateNavigation({@required this.isShowBackButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: HexColor(Color.COLOR_MAIN),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          isShowBackButton
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: Container(
                      width: 40,
                      child: Image.asset(
                          AssetUtils.instance().getImageUrl('ic_back.png')),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
