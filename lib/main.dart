// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ludoflame/components/board_component.dart';
import 'package:ludoflame/providers/game_provider.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const Ludo());
}

class Ludo extends StatelessWidget {
  const Ludo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) {
            return GameProvider();
          },
        )
      ],
      builder: (context, child) {
        return GameWidget(
          game: MyGame(
            gameProvider: Provider.of<GameProvider>(
              context,
              listen: false,
            ),
          ),
        );
      },
    );
  }
}

class MyGame extends FlameGame {
  final GameProvider gameProvider;
  MyGame({
    required this.gameProvider,
  });
  @override
  Future<void> onLoad() async {
    double canvasSize = (size.x) * 0.7;
    add(BoardSquare(
      boardPosition: size / 2,
      canvasSize: canvasSize,
      gameProvider: gameProvider,
    ));
  }
}
