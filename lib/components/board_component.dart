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
          textToShow: "${i % 15}",
          tilePaint: BasicPalette.red.paint()));
    }
    List<List<TileComponent>> gridTileList = List.generate(15, (index) {
      return boardTiles.sublist(index * 15, (index * 15 + 15));
    });
    List<List<Vector2>> gridTileCorrList = List.generate(15, (index) {
      return rowData.sublist(index * 15, (index * 15 + 15));
    });
    // 4 regions call A.B,C,D
    // build Player Initial Positions
    List<Player> players = PlayerMethods.getPlayers;
    Vector2 boardCenter = (rowData[0] + rowData[224]) / 2;
    // outer positions
    List<List<TileComponent>> playerPlacingPositions = players.map((player) {
      Vector2 start = gridTileCorrList[player.playerBirthPlace.first.first]
          [player.playerBirthPlace.first.last];
      Vector2 end = gridTileCorrList[player.playerBirthPlace.last.first]
          [player.playerBirthPlace.last.last];
      return [
        TileComponent(
          canvasPosition: (start + end) / 2,
          canvasSize: tileSize * 6,
          textToShow: player.player.name,
          tilePaint: player.color,
        ),
        TileComponent(
          canvasPosition: (start + end) / 2,
          canvasSize: tileSize * 4,
          textToShow: player.player.name,
          tilePaint: BasicPalette.lightPink.paint(),
        )
      ];
    }).toList();

    addAll(boardTiles);
    addAll(playerPlacingPositions.map((e) => e.first));
    addAll(playerPlacingPositions.map((e) => e.last));
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
    // TODO: build final tracks

    List<TileComponent> playerFirstSteps = players.map((player) {
      return TileComponent(
        canvasPosition: gridTileCorrList[player.playerFirstStep.first]
            [player.playerFirstStep.last],
        canvasSize: tileSize,
        tilePaint: player.color,
      );
    }).toList();
    addAll(playerFirstSteps);
    List<List<TileComponent>> finalTrackBuild = players.map((player) {
      List<List<int>> playerFinalTrack = player.playerFinalTrack;
      return playerFinalTrack.map((finalCorr) {
        Vector2 start = gridTileCorrList[finalCorr.first][finalCorr.last];
        return TileComponent(
          canvasPosition: (start),
          canvasSize: tileSize,
          tilePaint: player.color,
        );
      }).toList();
    }).toList();
    for (var track in finalTrackBuild) {
      addAll(track);
    }
    return super.onLoad();
  }
}
