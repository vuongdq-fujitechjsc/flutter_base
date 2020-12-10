import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimamu/core/core.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/app.dart';
import '../../utilities/utility.dart';
import '../base_page/base_page.dart';
import '../custom_appbar.dart';

import 'my_navigation_bloc.dart';

enum NavigationLeftButtonType {
  iconBack,
  iconMenu,
  iconOther,
}

enum NavigationCenterType {
  title,
  icon,
}

enum NavigationRightButtonType {
  iconSwitchCalendarList,
  iconNotification,
  iconOther,
}

class NavigationData {
  final NavigationLeftButtonType navigationLeftButtonType;
  final NavigationCenterType navigationCenterType;
  final NavigationRightButtonType navigationRightButtonType;

  final String navigationTitle;
  final Widget rightButton;

  final bool isShowNavigation;

  const NavigationData({
    this.navigationLeftButtonType,
    this.navigationCenterType,
    this.navigationRightButtonType,
    this.navigationTitle,
    this.rightButton,
    this.isShowNavigation = false,
  });
}

class MyNavigation extends StatefulWidget {
  final Widget bodyWidget;
  final NavigationData navigationData;
  final void Function() tapMenuButton;
  final void Function() customBackAction;
  final PublishSubject<String> navigationTitleStream;

  MyNavigation({
    this.bodyWidget,
    this.navigationData,
    this.tapMenuButton,
    this.customBackAction,
    this.navigationTitleStream,
  });

  @override
  _MyNavigationState createState() => _MyNavigationState();
}

class _MyNavigationState
    extends BasePage<MyNavigation, MyNavigationBloc, AppBloc> {
  Stream<String> get _titleStream => widget.navigationTitleStream == null
      ? null
      : widget.navigationTitleStream.stream;

  @override
  void initState() {
    super.initState();
    LogUtils.debug('MyNavigationWidget - initState');
  }

  @override
  MyNavigationBloc getBlocData(BuildContext context) => MyNavigationBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNavigationBar(widget.navigationData),
        Expanded(
          child: widget.bodyWidget,
        )
      ],
    );
  }

  Widget _buildNavigationBar(NavigationData navigationData) {
    return PreferredSize(
      child: navigationData.isShowNavigation ? CustomAppBar(
        backgroundColor: HexColor(Color.COLOR_MAIN),
        leading: _buildLeftButton(navigationData.navigationLeftButtonType),
        title: StreamBuilder(
          stream: _titleStream,
          builder: (context, AsyncSnapshot<String> snapshot) {
            return Text(
              (snapshot.hasData)
                  ? snapshot.data
                  : navigationData.navigationTitle,
              style: TextStyle(
                color: HexColor(Color.COLOR_WHITE),
                fontSize: Dimension.textSize18,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        trailing: _buildRightButton(navigationData.navigationRightButtonType),
      )
      : Container(),
      preferredSize: Size.fromHeight(44),
    );
  }

  Widget _buildLeftButton(type) {
    switch (type) {
      case NavigationLeftButtonType.iconMenu:
        return Container(
          transform: Matrix4.translationValues(1, 0, 0),
          child: IconButton(
            icon: Image.asset(
              AssetUtils.instance().getImageUrl('ic_navigation_menu_list.png'),
            ),
            onPressed: () {
              widget.tapMenuButton();
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          ),
        );
        break;
      case NavigationLeftButtonType.iconBack:
        return GestureDetector(
          child: Container(
            transform: Matrix4.translationValues(-6, 0, 0),
            child: Image.asset(
              AssetUtils.instance().getImageUrl('ic_back_navigation_menu.png'),
            ),
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            widget.customBackAction == null
                ? Navigator.pop(context)
                : widget.customBackAction();
          },
        );
        break;
      case NavigationLeftButtonType.iconOther:
        return Container();
        break;
      default:
        return Container();
    }
  }

  Widget _buildRightButton(type) {
    switch (type) {
      case NavigationRightButtonType.iconSwitchCalendarList:
        return Container();
        break;
      case NavigationRightButtonType.iconNotification:
        return Container();
      case NavigationRightButtonType.iconOther:
        return widget.navigationData.rightButton;
        break;
      default:
        return Container();
    }
  }
}
