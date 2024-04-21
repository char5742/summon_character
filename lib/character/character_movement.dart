import 'dart:math';

import 'package:web/web.dart';

import 'chatacter.dart';

class CharacterMovement {
  final double _moveDistance;
  Position _currentPosition;
  Position? destinationPosition;

  CharacterMovement(this._currentPosition, this._moveDistance);

  /// キャラクターの目的地に向かって移動する
  void moveTowardDestination() {
    if (destinationPosition == null) {
      return;
    }

    final topDiff = destinationPosition!.top - _currentPosition.top;
    final leftDiff = destinationPosition!.left - _currentPosition.left;

    final viewportWidth = _getViewportWidth();
    final viewportHeight = _getViewportHeight();
    final moveDirection = _getMoveDirection(topDiff, leftDiff);
    final moveScale =
        _getMoveScale(viewportWidth, viewportHeight, moveDirection);
    final step = _calculateStep(moveDirection, moveScale);

    _updateCurrentPosition(moveDirection, step);
  }

  double _getViewportWidth() {
    return max(document.documentElement?.clientWidth ?? 0, window.innerWidth)
        .toDouble();
  }

  double _getViewportHeight() {
    return max(document.documentElement?.clientHeight ?? 0, window.innerHeight)
        .toDouble();
  }

  _MoveDirection _getMoveDirection(double topDiff, double leftDiff) {
    return topDiff.abs() > leftDiff.abs()
        ? _MoveDirection.vertical
        : _MoveDirection.horizontal;
  }

  double _getMoveScale(double viewportWidth, double viewportHeight,
      _MoveDirection moveDirection) {
    return moveDirection == _MoveDirection.vertical
        ? viewportHeight > viewportWidth
            ? viewportWidth / viewportHeight
            : 1
        : viewportWidth > viewportHeight
            ? viewportHeight / viewportWidth
            : 1;
  }

  double _calculateStep(_MoveDirection moveDirection, double moveScale) {
    return moveDirection == _MoveDirection.vertical
        ? (destinationPosition!.top - _currentPosition.top > 0
                ? _moveDistance
                : -_moveDistance) *
            moveScale
        : (destinationPosition!.left - _currentPosition.left > 0
                ? _moveDistance
                : -_moveDistance) *
            moveScale;
  }

  void _updateCurrentPosition(_MoveDirection moveDirection, double step) {
    if (moveDirection == _MoveDirection.vertical) {
      _currentPosition =
          (top: _currentPosition.top + step, left: _currentPosition.left);
    } else {
      _currentPosition =
          (top: _currentPosition.top, left: _currentPosition.left + step);
    }
  }

  /// キャラクターが目的地に到達したかどうかを判定する
  bool isAtDestination() {
    if (destinationPosition == null) {
      return false;
    }

    final topDiff = destinationPosition!.top - _currentPosition.top;
    final leftDiff = destinationPosition!.left - _currentPosition.left;

    return topDiff.abs() <= _moveDistance && leftDiff.abs() <= _moveDistance;
  }

  Position get currentPosition => _currentPosition;
}

enum _MoveDirection {
  vertical,
  horizontal,
}
