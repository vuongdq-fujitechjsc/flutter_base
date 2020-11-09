import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mimamu/core/live_data/lifecycle.dart';
import 'package:mimamu/core/live_data/live_data_implement.dart';
import 'package:mimamu/3.%20Utilities/log_util.dart';
import 'package:mimamu/4.%20Base/Event/rx_bus_model.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  LiveData<RxEventModel> _liveData = LiveData();
  Bloc _parentBloc;
  StreamSubscription _subscription;
  LifecycleState _widgetState;

  BaseBloc(State initialState) : super(initialState);

  LiveData get liveData => _liveData;

  void injectBloc<T extends Bloc>(T parentBloc) {
    this._parentBloc = parentBloc;
    LogUtil.debug(
        'BaseBloc: InjectBloc ${parentBloc.toString()} to ${this.toString()}');
    if (this._parentBloc is BaseBloc) {
      _subscription =
          (this._parentBloc as BaseBloc).liveData.observerValue((value) {
        dispatchEvent(value);
      });
    }
  }

  Bloc get parentBloc => _parentBloc;

  void setWidgetState(LifecycleState widgetState) {
    this._widgetState = widgetState;
  }

  void dispatchEvent(RxEventModel event) {}

  void emitEvent(RxEventModel event) {
    if (this is BaseBloc) {
      this.liveData?.postValue(event);
    }
  }

  void dispose() {
    _liveData?.close();
    _subscription?.cancel()?.catchError((error) {
      LogUtil.error('${this.toString()} { error : $error}');
    });
  }
}
