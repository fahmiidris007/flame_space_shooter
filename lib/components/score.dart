import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_space_shooter/pages/space_shooter_page.dart';

class Score extends TextComponent with HasGameRef<SpaceShooterPage> {
  @override
  void update(double dt) {
    super.update(dt);

    text = 'Score: ${game.score}';
  }
}
