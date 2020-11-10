import '../events/events.dart';

import 'app_state.dart';
import 'app_event.dart';
import 'base_bloc.dart';

class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield AppAuthenticationFailure();
  }

  @override
  void dispatchEvent(RxEventModel event) {
    super.dispatchEvent(event);
  }
}
