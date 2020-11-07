import 'dart:async';

import 'package:mimamu/1.%20Commons/LiveData/live_data_interface.dart';
import 'package:mimamu/4.%20Base/Event/rx_bus_model.dart';
import 'package:rxdart/subjects.dart';

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
        .map((event) => event is RxEventModel && event.data is T)
        .listen((event) {
      callBack(event);
    });
    _listStreamSubscription.add(subscription);
    return subscription;
  }
}
