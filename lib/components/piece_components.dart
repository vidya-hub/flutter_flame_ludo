import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class PieceComponent extends CircleComponent with TapCallbacks {
  static final Paint red = BasicPalette.red.paint();
  Vector2 canvasPosition;
  double pieceRadius;
  Paint? tilePaint;
  String? textToShow;
  Function(TapDownEvent)? onTap;

  PieceComponent({
    required this.pieceRadius,
    required this.canvasPosition,
    this.tilePaint,
    this.textToShow,
    this.onTap,
  }) : super(
            position: canvasPosition,
            radius: pieceRadius,
            anchor: Anchor.center,
            paint: tilePaint ?? red,
            children: [
              TextComponent(
                text: textToShow,
                size: Vector2.all(0.7),
                scale: Vector2.all(0.7),
              )
            ]);
  @override
  void onTapDown(TapDownEvent event) {
    if (onTap != null) {
      onTap!(event);
    }
    super.onTapDown(event);
  }
}
