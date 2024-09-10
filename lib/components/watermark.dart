import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_space_shooter/pages/space_shooter_page.dart';

class Watermark extends TextComponent with HasGameRef<SpaceShooterPage> {
  Watermark()
      : super(
          scale: Vector2(0.5, 0.5),
        );

  @override
  FutureOr<void> onLoad() {
    text = '\t\t\t\tPowered by :\nFahmi Production';
  }
}
