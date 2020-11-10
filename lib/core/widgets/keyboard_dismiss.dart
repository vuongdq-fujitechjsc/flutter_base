import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

enum GestureType {
  onTapDown,
  onTapUp,
  onTap,
  onTapCancel,
  onSecondaryTapDown,
  onSecondaryTapUp,
  onSecondaryTapCancel,
  onDoubleTap,
  onLongPress,
  onLongPressStart,
  onLongPressMoveUpdate,
  onLongPressUp,
  onLongPressEnd,
  onVerticalDragDown,
  onVerticalDragStart,
  onVerticalDragUpdate,
  onVerticalDragEnd,
  onVerticalDragCancel,
  onHorizontalDragDown,
  onHorizontalDragStart,
  onHorizontalDragUpdate,
  onHorizontalDragEnd,
  onHorizontalDragCancel,
  onForcePressStart,
  onForcePressPeak,
  onForcePressUpdate,
  onForcePressEnd,
  onPanDown,
  onPanStart,
  onPanUpdateAnyDirection,
  onPanUpdateDownDirection,
  onPanUpdateUpDirection,
  onPanUpdateLeftDirection,
  onPanUpdateRightDirection,
  onPanEnd,
  onPanCancel,
  onScaleStart,
  onScaleUpdate,
  onScaleEnd,
}

class KeyboardDismiss extends StatelessWidget {
  const KeyboardDismiss({
    Key key,
    this.child,
    this.behavior,
    this.gestures = const [GestureType.onTap],
    this.dragStartBehavior = DragStartBehavior.start,
    this.excludeFromSemantics = false,
  })  : assert(gestures != null),
        super(key: key);

  final List<GestureType> gestures;

  final DragStartBehavior dragStartBehavior;

  final HitTestBehavior behavior;

  final bool excludeFromSemantics;

  final Widget child;

  void _shouldUnFocus(BuildContext context) =>
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

  void _shouldUnFocusWithDetails(
      BuildContext context,
      DragUpdateDetails details,
      ) {

    final dy = details.delta.dy;
    final dx = details.delta.dx;
    final isMainlyHorizontal = dx.abs() - dy.abs() > 0;
    
    if (gestures.contains(GestureType.onPanUpdateDownDirection) &&
        dy > 0 &&
        !isMainlyHorizontal) {
      _shouldUnFocus(context);
    } else if (gestures.contains(GestureType.onPanUpdateUpDirection) &&
        dy < 0 &&
        !isMainlyHorizontal) {
      _shouldUnFocus(context);
    } else if (gestures.contains(GestureType.onPanUpdateRightDirection) &&
        dx > 0 &&
        isMainlyHorizontal) {
      _shouldUnFocus(context);
    } else if (gestures.contains(GestureType.onPanUpdateLeftDirection) &&
        dx < 0 &&
        isMainlyHorizontal) {
      _shouldUnFocus(context);
    }
  }

  bool _gesturesContainsDirectionalPanUpdate() =>
      gestures.contains(GestureType.onPanUpdateDownDirection) ||
          gestures.contains(GestureType.onPanUpdateUpDirection) ||
          gestures.contains(GestureType.onPanUpdateRightDirection) ||
          gestures.contains(GestureType.onPanUpdateLeftDirection);

  @override
  Widget build(BuildContext context) => GestureDetector(
    excludeFromSemantics: excludeFromSemantics,
    dragStartBehavior: dragStartBehavior,
    behavior: behavior,
    onTap: gestures.contains(GestureType.onTap)
        ? () => _shouldUnFocus(context)
        : null,
    onTapDown: gestures.contains(GestureType.onTapDown)
        ? (_) => _shouldUnFocus(context)
        : null,
    onPanUpdate: gestures.contains(GestureType.onPanUpdateAnyDirection)
        ? (_) => _shouldUnFocus(context)
        : null,
    onTapUp: gestures.contains(GestureType.onTapUp)
        ? (_) => _shouldUnFocus(context)
        : null,
    onTapCancel: gestures.contains(GestureType.onTapCancel)
        ? () => _shouldUnFocus(context)
        : null,
    onSecondaryTapDown: gestures.contains(GestureType.onSecondaryTapDown)
        ? (_) => _shouldUnFocus(context)
        : null,
    onSecondaryTapUp: gestures.contains(GestureType.onSecondaryTapUp)
        ? (_) => _shouldUnFocus(context)
        : null,
    onSecondaryTapCancel:
    gestures.contains(GestureType.onSecondaryTapCancel)
        ? () => _shouldUnFocus(context)
        : null,
    onDoubleTap: gestures.contains(GestureType.onDoubleTap)
        ? () => _shouldUnFocus(context)
        : null,
    onLongPress: gestures.contains(GestureType.onLongPress)
        ? () => _shouldUnFocus(context)
        : null,
    onLongPressStart: gestures.contains(GestureType.onLongPressStart)
        ? (_) => _shouldUnFocus(context)
        : null,
    onLongPressMoveUpdate:
    gestures.contains(GestureType.onLongPressMoveUpdate)
        ? (_) => _shouldUnFocus(context)
        : null,
    onLongPressUp: gestures.contains(GestureType.onLongPressUp)
        ? () => _shouldUnFocus(context)
        : null,
    onLongPressEnd: gestures.contains(GestureType.onLongPressEnd)
        ? (_) => _shouldUnFocus(context)
        : null,
    onVerticalDragDown: gestures.contains(GestureType.onVerticalDragDown)
        ? (_) => _shouldUnFocus(context)
        : null,
    onVerticalDragStart: gestures.contains(GestureType.onVerticalDragStart)
        ? (_) => _shouldUnFocus(context)
        : null,
    onVerticalDragUpdate: _gesturesContainsDirectionalPanUpdate()
        ? (details) => _shouldUnFocusWithDetails(context, details)
        : null,
    onVerticalDragEnd: gestures.contains(GestureType.onVerticalDragEnd)
        ? (_) => _shouldUnFocus(context)
        : null,
    onVerticalDragCancel:
    gestures.contains(GestureType.onVerticalDragCancel)
        ? () => _shouldUnFocus(context)
        : null,
    onHorizontalDragDown:
    gestures.contains(GestureType.onHorizontalDragDown)
        ? (_) => _shouldUnFocus(context)
        : null,
    onHorizontalDragStart:
    gestures.contains(GestureType.onHorizontalDragStart)
        ? (_) => _shouldUnFocus(context)
        : null,
    onHorizontalDragUpdate: _gesturesContainsDirectionalPanUpdate()
        ? (details) => _shouldUnFocusWithDetails(context, details)
        : null,
    onHorizontalDragEnd: gestures.contains(GestureType.onHorizontalDragEnd)
        ? (_) => _shouldUnFocus(context)
        : null,
    onHorizontalDragCancel:
    gestures.contains(GestureType.onHorizontalDragCancel)
        ? () => _shouldUnFocus(context)
        : null,
    onForcePressStart: gestures.contains(GestureType.onForcePressStart)
        ? (_) => _shouldUnFocus(context)
        : null,
    onForcePressPeak: gestures.contains(GestureType.onForcePressPeak)
        ? (_) => _shouldUnFocus(context)
        : null,
    onForcePressUpdate: gestures.contains(GestureType.onForcePressUpdate)
        ? (_) => _shouldUnFocus(context)
        : null,
    onForcePressEnd: gestures.contains(GestureType.onForcePressEnd)
        ? (_) => _shouldUnFocus(context)
        : null,
    onPanDown: gestures.contains(GestureType.onPanDown)
        ? (_) => _shouldUnFocus(context)
        : null,
    onPanStart: gestures.contains(GestureType.onPanStart)
        ? (_) => _shouldUnFocus(context)
        : null,
    onPanEnd: gestures.contains(GestureType.onPanEnd)
        ? (_) => _shouldUnFocus(context)
        : null,
    onPanCancel: gestures.contains(GestureType.onPanCancel)
        ? () => _shouldUnFocus(context)
        : null,
    onScaleStart: gestures.contains(GestureType.onScaleStart)
        ? (_) => _shouldUnFocus(context)
        : null,
    onScaleUpdate: gestures.contains(GestureType.onScaleUpdate)
        ? (_) => _shouldUnFocus(context)
        : null,
    onScaleEnd: gestures.contains(GestureType.onScaleEnd)
        ? (_) => _shouldUnFocus(context)
        : null,
    child: child,
  );
}