import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_space_shooter/pages/space_shooter_page.dart';

class Player extends SpriteComponent with HasGameRef<SpaceShooterPage> {
  Player()
      : super(
          size: Vector2(100, 150),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('player.png');

    position = gameRef.size / 2;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
