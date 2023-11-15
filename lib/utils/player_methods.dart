import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'package:ludoflame/model/piece_model.dart';
import 'package:ludoflame/model/player_model.dart';
import 'package:ludoflame/utils/players_enum.dart';

class PlayerMethods {
  static String getPieceName(PlayerName playerName, int index) {
    return "${playerName.name}-$index";
  }

  static List<Player> getPlayers({
    required List<List<Vector2>> gridCorrList,
    required double tileSize,
  }) {
    List<List<List<int>>> playersBoundary = [
      [
        [0, 0],
        [5, 5]
      ],
      [
        [0, 9],
        [5, 14]
      ],
      [
        [9, 9],
        [14, 14]
      ],
      [
        [9, 0],
        [14, 5],
      ]
    ];
    List<List<Vector2>> playerStaringPositions = getPlayerStartingPoints(
        gridCorrList: gridCorrList,
        playersBoundary: playersBoundary,
        tileSize: tileSize);
    return [
      Player(
          color: BasicPalette.lightRed.paint(),
          player: PlayerName.A,
          playerBirthPlace: playersBoundary[0],
          playerEndingPlaceIndexes: [0, 3],
          playerPieces: List.generate(
            4,
            (index) => Piece(
              currentPosition: playerStaringPositions[0][index],
              initialStep: [],
              birthPoint: [],
              pieceName: getPieceName(PlayerName.A, index),
            ),
          ),
          playerFirstStep: [6, 1],
          piecesRemained: 4,
          // 8 th row will be player 1 final
          playerFinalTrack: List.generate(
            6,
            (index) => [7, index + 1],
          )),
      Player(
        color: BasicPalette.yellow.paint(),
        player: PlayerName.C,
        playerBirthPlace: playersBoundary[1],
        playerEndingPlaceIndexes: [1, 0],
        playerPieces: List.generate(
          4,
          (index) => Piece(
            currentPosition: playerStaringPositions[1][index],
            initialStep: [],
            birthPoint: [],
            pieceName: getPieceName(PlayerName.B, index),
          ),
        ),
        playerFirstStep: [1, 8],
        piecesRemained: 4,
        // 8 th column will be player 2 final
        playerFinalTrack: List.generate(
          6,
          (index) => [index + 1, 7],
        ),
      ),
      Player(
        color: BasicPalette.green.paint(),
        player: PlayerName.B,
        playerBirthPlace: playersBoundary[2],
        playerEndingPlaceIndexes: [1, 2],
        playerPieces: List.generate(
          4,
          (index) => Piece(
            currentPosition: playerStaringPositions[2][index],
            initialStep: [],
            birthPoint: [],
            pieceName: getPieceName(PlayerName.C, index),
          ),
        ),
        playerFirstStep: [8, 13],
        piecesRemained: 4,
        // 8 th row will be player 3 final
        playerFinalTrack: List.generate(
          6,
          (index) => [7, (13 - index)],
        ),
      ),
      Player(
        color: BasicPalette.blue.paint(),
        player: PlayerName.D,
        playerBirthPlace: playersBoundary[3],
        playerEndingPlaceIndexes: [2, 3],
        playerPieces: List.generate(
          4,
          (index) => Piece(
            currentPosition: playerStaringPositions[3][index],
            initialStep: [],
            birthPoint: [],
            pieceName: getPieceName(PlayerName.D, index),
          ),
        ),
        playerFirstStep: [13, 6],
        piecesRemained: 4,
        // 8 th row will be player 4 final
        playerFinalTrack: List.generate(
          6,
          (index) => [(13 - index), 7],
        ),
      ),
    ];
  }

  static List<List<Vector2>> getPlayerStartingPoints({
    required List<List<Vector2>> gridCorrList,
    required List<List<List<int>>> playersBoundary,
    required double tileSize,
  }) {
    return playersBoundary.map((playerBoundary) {
      Vector2 start =
          gridCorrList[playerBoundary.first.first][playerBoundary.first.last];
      Vector2 end =
          gridCorrList[playerBoundary.last.first][playerBoundary.last.last];
      List<Vector2> placingRect = Rect.fromCenter(
        center: ((start + end) / 2).toOffset(),
        height: tileSize * 2,
        width: tileSize * 2,
      ).toVertices();
      return placingRect;
    }).toList();
  }
}
