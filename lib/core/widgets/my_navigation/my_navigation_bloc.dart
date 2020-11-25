import '../../app/app.dart';

import 'my_navigation.event.dart';
import 'my_navigation_state.dart';

class MyNavigationBloc extends BaseBloc<MyNavigationEvent, MyNavigationState> {
  MyNavigationBloc() : super(MyNavigationInitial());

  @override
  Stream<MyNavigationState> mapEventToState(MyNavigationEvent event) async* {
    
  }

}
