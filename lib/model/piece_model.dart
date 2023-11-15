// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flame/components.dart';

class Piece {
  Vector2 currentPosition;
  List<int> initialStep;
  List<int> birthPoint;
  String pieceName;
  Piece({
    required this.currentPosition,
    required this.initialStep,
    required this.birthPoint,
    required this.pieceName,
  });

  Piece copyWith({
    Vector2? currentPosition,
    List<int>? initialStep,
    List<int>? birthPoint,
    String? pieceName,
  }) {
    return Piece(
      currentPosition: currentPosition ?? this.currentPosition,
      initialStep: initialStep ?? this.initialStep,
      birthPoint: birthPoint ?? this.birthPoint,
      pieceName: pieceName ?? this.pieceName,
    );
  }
}
