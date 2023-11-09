import 'package:flame/palette.dart';
import 'package:ludoflame/model/player_model.dart';
import 'package:ludoflame/utils/players.dart';

class PlayerMethods {
  static List<Player> get getPlayers {
    return [
      Player(
          color: BasicPalette.lightRed.paint(),
          player: PlayerName.A,
          playerBirthPlace: [0, 80],
          playerEndingPlaceIndexes: [0, 3]),
      Player(
          color: BasicPalette.yellow.paint(),
          player: PlayerName.B,
          playerBirthPlace: [89, 9],
          playerEndingPlaceIndexes: [1, 0]),
      Player(
          color: BasicPalette.green.paint(),
          player: PlayerName.C,
          playerBirthPlace: [144, 224],
          playerEndingPlaceIndexes: [1, 2]),
      Player(
          color: BasicPalette.blue.paint(),
          player: PlayerName.D,
          playerBirthPlace: [210, 140],
          playerEndingPlaceIndexes: [2, 3]),
    ];
  }
}
