import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'package:ludoflame/components/piece_components.dart';
import 'package:ludoflame/components/polygon_component.dart';
import 'package:ludoflame/components/tile_component.dart';
import 'package:ludoflame/model/game_model.dart';
import 'package:ludoflame/model/player_model.dart';
import 'package:ludoflame/providers/game_provider.dart';
import 'package:ludoflame/utils/player_methods.dart';
import 'package:ludoflame/utils/players_enum.dart';

class BoardSquare extends RectangleComponent {
  final GameProvider gameProvider;

  final Vector2 boardPosition;
  double canvasSize;
  BoardSquare({
    required this.boardPosition,
    required this.canvasSize,
    required this.gameProvider,
  }) : super(
          position: boardPosition,
          size: Vector2.all(canvasSize),
          anchor: Anchor.center,
        );
  List<Vector2> rowData = [];
  List<TileComponent> boardTiles = [];
  List<List<Vector2>> gridTileCorrList = [];
  List<Player> players = [];
  bool setUpDone = false;
  String? selectedPiece;
  List<List<PieceComponent>> playerPieceComponents = [];
  @override
  FutureOr<void> onLoad() {
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
        tilePaint: BasicPalette.red.paint(),
        onTap: (tileTap) {
          if (selectedPiece != null && setUpDone) {
            String playerName = selectedPiece!.split("-").first;
            int selectedPlayerPieceIndex =
                int.parse(selectedPiece!.split("-").last);
            int indexOfPlayer = playerNameIndex(playerName);
            PieceComponent component =
                playerPieceComponents[indexOfPlayer][selectedPlayerPieceIndex];
            component.position = rowData[i];
            print(component.position);
          }
        },
      ));
    }
    gridTileCorrList = List.generate(15, (index) {
      return rowData.sublist(index * 15, (index * 15 + 15));
    });
    print("Called");
    // 4 regions call A.B,C,D
    // build Player Initial Positions
    players = PlayerMethods.getPlayers(
      gridCorrList: gridTileCorrList,
      tileSize: tileSize,
    );
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
        ),
      ];
    }).toList();

    addAll(boardTiles);
    addAll(playerPlacingPositions.map((e) => e.first));
    addAll(playerPlacingPositions.map((e) => e.last));
    for (var player in players) {
      List<PieceComponent> pieceComponents = player.playerPieces.indexed
          .map(
            (piece) => PieceComponent(
              pieceRadius: tileSize * 0.4,
              canvasPosition: piece.$2.currentPosition,
              tilePaint: player.color,
              textToShow: "${player.player.name}-${piece.$1}",
              onTap: (p0) {
                selectedPiece = "${player.player.name}-${piece.$1}";
              },
            ),
          )
          .toList();
      addAll(pieceComponents);
      playerPieceComponents.add(pieceComponents);
    }
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
    setUpDone = true;

    return super.onLoad();
  }
}
