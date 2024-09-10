import 'package:flame/components.dart';
import 'package:flame_space_shooter/pages/space_shooter_page.dart';

class Live extends TextComponent with HasGameRef<SpaceShooterPage> {
  @override
  void update(double dt) {
    super.update(dt);

    text = 'Lives: ${game.lives}';

    if (game.lives == 0) {
      game.gameOver();
    }
  }
}
