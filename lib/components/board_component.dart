import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'package:ludoflame/components/polygon_component.dart';
import 'package:ludoflame/components/tile_component.dart';
import 'package:ludoflame/model/game_model.dart';
import 'package:ludoflame/model/player_model.dart';
import 'package:ludoflame/utils/player_methods.dart';

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

  @override
  FutureOr<void> onLoad() {
    List<Vector2> rowData = [];
    List<TileComponent> boardTiles = [];
    double tileSize = (canvasSize / 15);
    Vector2 movingTilePosition = Vector2(-tileSize / 2, -tileSize / 2);
    for (var i = 0; i < 225; i++) {
      movingTilePosition = Vector2(
        movingTilePosition.x + (tileSize),
        movingTilePosition.y,
      );

      if (i % 15 == 0) {
        movingTilePosition = Vector2(
          tileSize / 2,
          movingTilePosition.y + tileSize,
        );
      }
      rowData.add(movingTilePosition);
      boardTiles.add(TileComponent(
          canvasPosition: movingTilePosition,
          canvasSize: tileSize,
          textToShow: (i).toString(),
          tilePaint: BasicPalette.red.paint()));
    }
    // 4 regions call A.B,C,D
    // build Player Initial Positions
    List<Player> players = PlayerMethods.getPlayers;
    Vector2 boardCenter = (rowData[0] + rowData[224]) / 2;
    List<TileComponent> playerPlacingPositions = players.map((player) {
      return TileComponent(
        canvasPosition: (rowData[player.playerBirthPlace.first] +
                rowData[player.playerBirthPlace.last]) /
            2,
        canvasSize: tileSize * 6,
        textToShow: player.player.name,
        tilePaint: player.color,
      );
    }).toList();

    addAll(boardTiles);
    addAll(playerPlacingPositions);
    // A endPosition
    List<Vector2> playerPlaceEndingVertices =
        GameModel.centerRectangleVerticesPositions.map(
      (pos) {
        return boardTiles[pos].toRect().topLeft.toVector2();
      },
    ).toList();
    List<TriangleComponent> playerEndings = players
        .map(
          (e) => TriangleComponent(
            triangleVertices: [
              ...e.playerEndingPlaceIndexes
                  .map((e) => playerPlaceEndingVertices[e]),
              boardCenter,
            ],
            tilePaint: e.color,
          ),
        )
        .toList();
    addAll(playerEndings);

    // add(TriangleComponent(triangleVertices: [
    //   playerPlaceEndingVertices.first,
    //   boardCenter,
    //   playerPlaceEndingVertices[2]
    // ], tilePaint: BasicPalette.black.paint()));
    //
    // add(TileComponent(
    //   canvasPosition: gridCoordinates[10].first,
    //   canvasSize: tileSize,
    //   textToShow: player.player.name,
    //   tilePaint: player.color,
    // ));
    // for (List<Vector2> xPath in gridCoordinates) {

    // }
    return super.onLoad();
  }
}
