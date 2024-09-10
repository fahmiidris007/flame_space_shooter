import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_space_shooter/components/bullets.dart';
import 'package:flame_space_shooter/components/enemy.dart';
import 'package:flame_space_shooter/components/explosion.dart';
import 'package:flame_space_shooter/pages/space_shooter_page.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterPage>, CollisionCallbacks {
  Player()
      : super(
          size: Vector2(100, 150),
          anchor: Anchor.center,
        );

  late final SpawnComponent _bulletSpawner;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(32, 48),
      ),
    );

    position = game.size / 2;

    add(RectangleHitbox());

    _bulletSpawner = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
          position: position +
              Vector2(
                0,
                -height / 2,
              ),
        );
      },
      autoStart: false,
    );

    game.add(_bulletSpawner);
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  void startShooting() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Enemy) {
      other.removeFromParent();
      game.add(Explosion(position: position));
      if (game.lives != 0) {
        game.lives -= 1;
      }
    }
  }
}
