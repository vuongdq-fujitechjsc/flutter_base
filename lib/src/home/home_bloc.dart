import 'package:enum_to_string/enum_to_string.dart';

import '../../core/core.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is ToggleMenuEvent) {
      (parentBloc as BaseBloc).emitEvent(
        RxEventModel(
          EnumToString.convertToString(EmitEventName.ToogleMenu),
          null,
          this.toString(),
        ),
      );
    }
  }

  @override
  void dispatchEvent(RxEventModel event) {
    super.dispatchEvent(event);
  }
}
