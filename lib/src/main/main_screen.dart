import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../home/home.dart';

import 'main_event.dart';
import 'main_state.dart';
import 'main_bloc.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  String _demoText;

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
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        ColoredBox(color: HexColor(Color.COLOR_MAIN)),
                        PreferredSize(
                          child: Container(),
                          preferredSize: Size.fromHeight(44),
                        ),
                        Center(
                          child: Text('Demo Menu'),
                        )
                      ],
                    ),
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
              HomeScreen(),
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

  _handleMenuState(context, state) {}
}
