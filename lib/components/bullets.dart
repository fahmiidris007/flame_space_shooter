import 'package:flame/components.dart';
import 'package:flame_space_shooter/pages/space_shooter_page.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterPage> {
  Bullet({
    super.position,
  }) : super(
          size: Vector2(25, 50),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'bullet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(8, 16),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += dt * -500;
    if (position.y < -height) {
      removeFromParent();
    }
  }
}
