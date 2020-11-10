import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../live_data/live_data.dart';

import 'rx_bus_model.dart';

class FluBus {
  PublishSubject<dynamic> _subject;
  List<StreamSubscription> _listStreamSubscription;

  FluBus.init() {
    _subject = PublishSubject();
    _listStreamSubscription = List();
  }

  static FluBus _instance;

  static FluBus getState() {
    if (_instance == null) {
      _instance = FluBus.init();
    }
    return _instance;
  }

  StreamSubscription<T> listen<T>(String message, OnDataReceiver callBack) {
    StreamSubscription subscription = _subject
        .where((event) =>
            event is RxEventModel &&
            event.message == message &&
            event.data != null &&
            event.data is T)
        // .map((event) => event is RxEventModel && event.data is T)
        .listen((event) {
      callBack(event.data);
    });
    _listStreamSubscription.add(subscription);
    return subscription;
  }

  StreamSubscription<T> listenDistinct<T>(
      String message, OnDataReceiver callBack) {
    StreamSubscription subscription = _subject
        .where((event) =>
            event is RxEventModel &&
            event.message == message &&
            event.data != null &&
            event.data is T)
        .distinct((oldModel, newModel) =>
            (oldModel as RxEventModel).message ==
            (newModel as RxEventModel).message)
        .map((event) => event is RxEventModel && event.data is T)
        .listen((event) {
      callBack(event);
    });
    _listStreamSubscription.add(subscription);
    return subscription;
  }

  void pushEvent(String message, dynamic data,
      {Duration delay = const Duration(seconds: 0)}) {
    Timer(delay, () {
      RxEventModel model = RxEventModel(message, data, this.toString());
      _subject.add(model);
    });
  }

  void unSubscribe([StreamSubscription subscription]) {
    subscription.cancel();
    if (_listStreamSubscription.contains(subscription)) {
      _listStreamSubscription.remove(subscription);
    }
  }

  void unSubscribeAll() {
    _listStreamSubscription.forEach((element) {
      element.cancel();
    });
    _listStreamSubscription.clear();
    _subject.close();
  }
}
