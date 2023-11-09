import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class TriangleComponent extends PolygonComponent with TapCallbacks {
  static final Paint red = BasicPalette.red.paint();
  List<Vector2> triangleVertices;
  Paint? tilePaint;
  String? textToShow;
  TriangleComponent({
    required this.triangleVertices,
    this.tilePaint,
    this.textToShow,
  }) : super(
          triangleVertices,
          anchor: Anchor.center,
          paint: tilePaint ?? red,
        );
}
