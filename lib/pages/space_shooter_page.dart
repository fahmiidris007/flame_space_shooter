import 'dart:async';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_space_shooter/components/player.dart';

class SpaceShooterPage extends FlameGame with PanDetector {
  late Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    player = Player();

    add(player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }
}
