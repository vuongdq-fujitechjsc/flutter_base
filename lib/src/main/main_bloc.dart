import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

import 'main_state.dart';
import 'main_event.dart';

class MainBloc extends BaseBloc<MainEvent, MainState> {
  final AppBloc appBloc;

  MainBloc({@required this.appBloc}) : super(MainInitial());

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    final currentState = state;

    //handle menu
    if (event is ToggleMenuEvent) {
      if (currentState is MainShowMenu) {
        yield new MainHideMenu();
      } else {
        yield new MainShowMenu();
      }
    } else if (event is MainMenuSetStatus) {
      yield new MainShowMenu();
    }
  }

  @override
  void dispatchEvent(RxEventModel event) {
    super.dispatchEvent(event);

    LogUtils.debug('MainBloc { DispatchEvent msg: ${event.message}}');

    if (event.message ==
        EnumToString.convertToString(EmitEventName.ToogleMenu)) {
      this.add(ToggleMenuEvent());
    }
  }
}
