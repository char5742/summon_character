import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:math';

import 'package:summon_character/chrome_api.dart';

import 'character_movement.dart';

typedef Position = ({
  /// 縦方向の位置 0~100
  double top,

  /// 横方向の位置 0~100
  double left,
});

class Character {
  static final Character instance = Character._internal();
  Character._internal();

  /// 1フレームの時間
  final _frameDuration = Duration(milliseconds: 1000 ~/ 240);

  /// キャラクターのスタイルに位置を反映する関数
  Function(Position)? applyPositionToStyle;

  Timer? _timer;

  late CharacterMovement _movement;

  Character();

  /// キャラクターの行動を開始する
  ///
  /// [_frameDuration]ごとにキャラクターの位置を更新し、
  /// [applyPositionToStyle]でスタイルに反映する
  startAction() async {
    await initialize();
    _timer = Timer.periodic(_frameDuration, (_) {
      // 目的地が設定されていない場合は目的地を設定する
      _movement.destinationPosition ??= _selectDestination();

      // 目的地に向かって移動する
      _movement.moveTowardDestination();

      // 目的地に到着したら次の目的地を選択する
      if (_movement.isAtDestination()) {
        _movement.destinationPosition = null;
      }

      // 画面に反映する
      applyPositionToStyle?.call(_movement.currentPosition);
    });
  }

  /// キャラクターの行動を停止する
  void stopAction() {
    _timer?.cancel();
    final jsPosition = JSPosition(
        top: _movement.currentPosition.top,
        left: _movement.currentPosition.left);
    chrome.storage.local.set(jsPosition);
  }

  /// キャラクターの初期化処理
  Future<void> initialize() async {
    final topObject = await chrome.storage.local.get("top").toDart;
    final leftObject = await chrome.storage.local.get("left").toDart;

    final top = (topObject as JSObject?)
        ?.getProperty<JSNumber>('top'.toJS)
        .toDartDouble;

    final left = (leftObject as JSObject?)
        ?.getProperty<JSNumber>('left'.toJS)
        .toDartDouble;

    _movement = CharacterMovement(
      (
        top: top ?? 50.0,
        left: left ?? 50.0,
      ),
      0.1,
    );
  }

  /// キャラクターの目的地を選択する
  Position _selectDestination() {
    // 20~80の範囲でランダムな位置を選択する
    final top = Random().nextInt(70) + 10.0;
    final left = Random().nextInt(70) + 10.0;
    return (top: top, left: left);
  }
}
