import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ludoflame/components/board_component.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}

class MyGame extends FlameGame with TapCallbacks {
  @override
  Future<void> onLoad() async {
    double canvasSize = (size.x) * 0.7;
    add(BoardSquare(
      boardPosition: size / 2,
      canvasSize: canvasSize,
    ));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!event.handled) {}
  }
}
