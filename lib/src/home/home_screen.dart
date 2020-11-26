import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';

import 'home_event.dart';
import 'home_state.dart';
import 'home_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeForm();
  }
}

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends BasePage<HomeForm, HomeBloc, AppBloc> {
  HomeBloc _bloc;

  @override
  HomeBloc getBlocData(BuildContext context) => _bloc;

  @override
  void initState() {
    super.initState();
    LogUtils.debug('HomeScreen - initState');

    _bloc = HomeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>.value(
      value: _bloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          return MyNavigation(
            navigationData: NavigationData(
              navigationLeftButtonType: NavigationLeftButtonType.iconMenu,
              navigationTitle: "Home Screen",
            ),
            tapMenuButton: () => bloc.add(ToggleMenuEvent()),
            bodyWidget: Container(),
          );
        },
        listener: (context, state) {
          _handleHomeState(context, state);
        },
      ),
    );
  }


  _handleHomeState(context, state) {}
}
