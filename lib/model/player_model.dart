// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:ludoflame/model/piece_model.dart';
import 'package:ludoflame/utils/players_enum.dart';

class Player {
  Paint color;
  PlayerName player;
  List<List<int>> playerBirthPlace;
  List<int> playerEndingPlaceIndexes;
  List<int> playerFirstStep;
  int piecesRemained;
  List<Piece> playerPieces;
  List<List<int>> playerFinalTrack;
  Player({
    required this.playerEndingPlaceIndexes,
    required this.color,
    required this.player,
    required this.playerBirthPlace,
    this.piecesRemained = 4,
    required this.playerFirstStep,
    required this.playerPieces,
    required this.playerFinalTrack,
  });

  Player copyWith({
    Paint? color,
    List<List<int>>? playerBirthPlace,
    List<int>? playerEndingPlaceIndexes,
    List<int>? playerFirstStep,
    int? piecesRemained,
    PlayerName? player,
    List<Piece>? playerPieces,
    List<List<int>>? playerFinalTrack,
  }) {
    return Player(
      playerPieces: playerPieces ?? this.playerPieces,
      player: player ?? this.player,
      color: color ?? this.color,
      playerBirthPlace: playerBirthPlace ?? this.playerBirthPlace,
      playerEndingPlaceIndexes:
          playerEndingPlaceIndexes ?? this.playerEndingPlaceIndexes,
      playerFirstStep: playerFirstStep ?? this.playerFirstStep,
      piecesRemained: piecesRemained ?? this.piecesRemained,
      playerFinalTrack: playerFinalTrack ?? this.playerFinalTrack,
    );
  }
}
