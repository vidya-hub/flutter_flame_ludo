import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:ludoflame/components/tile_component.dart';

class BoardSquare extends RectangleComponent with TapCallbacks {
  final Vector2 boardPosition;
  double canvasSize;
  BoardSquare({
    required this.boardPosition,
    required this.canvasSize,
  }) : super(
          position: boardPosition,
          size: Vector2.all(canvasSize),
          anchor: Anchor.center,
        );
  int rowCount = -1;
  @override
  FutureOr<void> onLoad() {
    List<Vector2> rowData = [];
    double tileSize = (canvasSize / 15);
    Vector2 movingTilePosition = Vector2(-tileSize / 2, -tileSize / 2);
    for (var i = 0; i < 225; i++) {
      movingTilePosition = Vector2(
        movingTilePosition.x + (tileSize),
        movingTilePosition.y,
      );

      if (i % 15 == 0) {
        rowCount += 1;
        movingTilePosition = Vector2(
          tileSize / 2,
          movingTilePosition.y + tileSize,
        );
      }
      rowData.add(movingTilePosition);

      add(TileComponent(
          canvasPosition: movingTilePosition,
          canvasSize: tileSize,
          textToShow: (i + 1).toString(),
          tilePaint: BasicPalette.red.paint()));
    }
    List<List<Vector2>> gridCoordinates = List.generate(15, (index) {
      return rowData.sublist(index, (index + 1) * 15);
    });
    // 4 regions call A.B,C,D names
    gridCoordinates.map((e) {
      e.sublist(
        0,
      );
    });

    return super.onLoad();
  }
}
