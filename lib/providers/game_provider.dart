import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

class GameProvider extends ChangeNotifier {
  Vector2 _tapEvent = Vector2.zero();
  Vector2 get tapEventPosition {
    return _tapEvent;
  }

  set setTapEvent(Vector2 tapPosition) {
    _tapEvent = tapPosition;
    print(tapEventPosition);
    notifyListeners();
  }
}
