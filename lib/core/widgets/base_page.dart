import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/app.dart';
import '../live_data/live_data.dart';

import 'base_page_ext.dart';
import 'view.dart';

abstract class BasePage<T extends StatefulWidget, K extends Bloc,
    C extends Bloc> extends State<T> with WidgetsBindingObserver, BasePageExt {
  K _bloc;

  void _onInitBlocData(BuildContext context) {
    var _parentBloc;

    try {
      _parentBloc = findBloc<C>(context);
    } catch (error) {
      _parentBloc = null;
    }

    _bloc = getBlocData(context);
    if (_parentBloc != null && _bloc is BaseBloc) {
      (_bloc as BaseBloc).injectBloc<C>(_parentBloc);
      (_bloc as BaseBloc).setWidgetState(lifecycleState);
    }
  }

  K getBlocData(BuildContext context);
  K get bloc => _bloc;

  LifecycleState _state = LifecycleState.INITIALIZED;

  OverlayEntry _overlayEntry;

  showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: InputDoneView(),
        );
      },
    );

    overlayState.insert(_overlayEntry);
  }

  removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //Listen keyboard and show/hide done bar above keyboard
    // KeyboardVisibilityNotification().addNewListener(onShow: () {
    //   showOverlay(context);
    // }, onHide: () {
    //   removeOverlay();
    // });
  }

  @override
  void didChangeDependencies() {
    if (_state == LifecycleState.INITIALIZED) {
      _onInitBlocData(context);
      _state = LifecycleState.CREATED;
      if (WidgetsBinding.instance.framesEnabled) {
        _state = LifecycleState.STARTED;
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _state = LifecycleState.DESTROYED;
    if (_bloc is BaseBloc) {
      (_bloc as BaseBloc).dispose();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _state = LifecycleState.RESUMED;
        break;
      case AppLifecycleState.inactive:
        _state = LifecycleState.STARTED;
        break;
      case AppLifecycleState.paused:
        _state = LifecycleState.PAUSED;
        break;
      case AppLifecycleState.detached:
        _state = LifecycleState.PAUSED;
        break;
    }
  }

  LifecycleState get lifecycleState => _state;
}
