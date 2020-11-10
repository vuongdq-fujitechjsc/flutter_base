import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../utilities/utility.dart';

import 'live_data_interface.dart';

class LiveData<T> {
  PublishSubject<T> _subject;
  StreamSubscription<T> _subscription;

  LiveData() {
    _subject = PublishSubject<T>();
  }

  void postValue(T value) {
    _subject.sink.add(value);
  }

  void postError(Object error) {
    _subject.addError(error);
  }

  StreamSubscription<T> observerValue(OnDataObserver dataObserver,
      {OnErrorValue onErrorValue}) {
    return _subscription = _subject.listen((value) {
      dataObserver(value);
    }, onError: onErrorValue);
  }

  Future<dynamic> close() {
    LogUtils.debug('LiveData close !');
    _subscription?.cancel();
    return _subject.close();
  }
}
