import 'dart:ui';

import 'package:ludoflame/utils/players.dart';

class Player {
  Paint color;
  PlayerName player;
  List<int> playerBirthPlace;
  List<int> playerEndingPlaceIndexes;
  Player({
    required this.playerEndingPlaceIndexes,
    required this.color,
    required this.player,
    required this.playerBirthPlace,
  });
}
