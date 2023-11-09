import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class TileComponent extends RectangleComponent with TapCallbacks {
  static final Paint red = BasicPalette.red.paint();
  Vector2 canvasPosition;
  double canvasSize;
  Paint? tilePaint;
  String? textToShow;
  TileComponent(
      {required this.canvasSize,
      required this.canvasPosition,
      this.tilePaint,
      this.textToShow})
      : super(
            position: canvasPosition,
            size: Vector2.all(canvasSize),
            anchor: Anchor.center,
            paint: tilePaint ?? red,
            children: [
              TextComponent(
                text: textToShow,
                anchor: Anchor.center,
                position: Vector2.all(canvasSize / 2),
              )
            ]);
}
