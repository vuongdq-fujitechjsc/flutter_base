import '../../core/core.dart';

import 'webview_event.dart';
import 'webview_state.dart';

class WebviewBloc extends BaseBloc<WebviewEvent, WebviewState> {
  WebviewBloc() : super(WebviewInitial());

  @override
  Stream<WebviewState> mapEventToState(WebviewEvent event) async* {}
}
