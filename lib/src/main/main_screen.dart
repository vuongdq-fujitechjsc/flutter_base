import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../routes/router.dart';
import '../home/home.dart';
import '../login/login.dart';

import 'main_event.dart';
import 'main_state.dart';
import 'main_bloc.dart';

enum SideMenuItem {
  changePassword,
  multiAccount,
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: FluroRouter.router.generator,
      home: MainForm(),
    );
  }
}

class MainForm extends StatefulWidget {
  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends BasePage<MainForm, MainBloc, AppBloc>
    with SingleTickerProviderStateMixin {
  AppBloc _appBloc;
  double _screenWidth, _screenHeight;

  bool _isCollapsed;

  final Duration _animationDuration = const Duration(milliseconds: 200);

  AnimationController _animationController;
  Animation<Offset> _slideMenuAnimation;

  @override
  void initState() {
    super.initState();
    LogUtils.debug('MainScreen - initState');

    _appBloc = BlocProvider.of<AppBloc>(context);

    _isCollapsed = true;

    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _slideMenuAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(_animationController);

    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reverse();
      _isCollapsed = true;
    }
  }

  @override
  MainBloc getBlocData(BuildContext context) =>
      MainBloc(appBloc: findBloc<AppBloc>(context));

  @override
  Widget build(BuildContext context) {
    _screenWidth = ScreenUtils.getInstance(context).width;
    _screenHeight = ScreenUtils.getInstance(context).height;

    return Scaffold(
      body: Stack(
        children: [
          sideMenu(context),
          containerAnimation(context),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _animationController?.dispose();
  }

  //Side menu
  Widget sideMenu(context) {
    return BlocProvider(
      create: (context) => this.bloc,
      child: BlocConsumer<MainBloc, MainState>(
        builder: (context, state) => Scaffold(
          backgroundColor: HexColor(Color.COLOR_WHITE),
          body: SlideTransition(
            position: _slideMenuAnimation,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: 0.6 * _screenWidth,
                  color: HexColor(Color.COLOR_WHITE),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: _screenHeight - 44.0 - 20.0,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppBar(
                                title:
                                    Text(multiLanguage.get('side_menu_title')),
                                backgroundColor: HexColor(Color.COLOR_MAIN),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _menuSelectItemRow(
                                  SideMenuItem.changePassword, state, context),
                              Divider(),
                              _menuSelectItemRow(
                                  SideMenuItem.multiAccount, state, context),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: HexColor(Color.COLOR_MAIN),
                        child: FlatButton(
                          child: Text(
                            multiLanguage.get('side_menu_logout'),
                            style: TextStyle(
                              color: HexColor(Color.COLOR_WHITE),
                            ),
                          ),
                          minWidth: 0.6 * _screenWidth,
                          height: 44.0,
                          onPressed: () => {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            )
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        listener: (context, state) => _handleMenuState(context, state),
      ),
    );
  }

  //Container Animation
  Widget containerAnimation(context) {
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: _isCollapsed ? 0 : 0.6 * _screenWidth,
      right: _isCollapsed ? 0 : -0.6 * _screenWidth,
      duration: _animationDuration,
      child: Material(
        animationDuration: _animationDuration,
        elevation: 0.0,
        child: containerMain(),
      ),
    );
  }

  //Container Main
  Widget containerMain() {
    return BlocProvider(
      create: (context) => this.bloc,
      child: BlocConsumer<MainBloc, MainState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              HomeScreen(),
              Visibility(
                visible: !_isCollapsed,
                child: Container(
                  color: Colors.black26,
                  width: _screenWidth,
                  height: _screenHeight,
                  child: FlatButton(
                    onPressed: () {
                      findBloc<MainBloc>(context).add(ToggleMenuEvent());
                    },
                    child: Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
        listener: (context, state) {
          if (state is MainShowMenu || state is MainHideMenu) {
            if (state is MainShowMenu) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }

            setState(() {
              _isCollapsed = state is MainHideMenu;
            });
          }
        },
      ),
    );
  }

  //SideMenu
  Widget _menuSelectItemRow(
      SideMenuItem type, MainState state, BuildContext context) {
    switch (type) {
      case SideMenuItem.changePassword:
        return MenuSelectItemRow(
          title: multiLanguage.get('side_menu_change_password'),
          onTap: () {
            setState(() {
              findBloc<MainBloc>(context).add(ToggleMenuEvent());
              Navigator.pushNamed(context, RouterID.CHANGE_PASSWORD);
            });
          },
        );
        break;
      case SideMenuItem.multiAccount:
        return MenuSelectItemRow(
          title: multiLanguage.get('side_menu_multi_account'),
          onTap: () {
            setState(() {
              findBloc<MainBloc>(context).add(ToggleMenuEvent());
              Navigator.pushNamed(context, RouterID.MULTI_ACCOUNT);
            });
          },
        );
        break;
      default:
        return Container();
    }
  }

  _handleMenuState(context, state) {}
}
