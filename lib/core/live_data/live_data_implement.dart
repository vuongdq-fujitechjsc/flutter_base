import 'dart:async';
import 'package:mimamu/1.%20Commons/LiveData/live_data_interface.dart';
import 'package:mimamu/3.%20Utilities/log_util.dart';
import 'package:rxdart/rxdart.dart';

class LiveData<T> {
  BehaviorSubject<T> _subject;
  StreamSubscription<T> _subscription;

  LiveData() {
    _subject = BehaviorSubject();
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
    LogUtil.debug('LiveData close !');
    _subscription?.cancel();
    return _subject.close();
  }
}
