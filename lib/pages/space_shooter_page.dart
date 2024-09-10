import 'dart:async';
import 'dart:developer';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/layout.dart';
import 'package:flame/parallax.dart';
import 'package:flame_space_shooter/components/enemy.dart';
import 'package:flame_space_shooter/components/lives.dart';
import 'package:flame_space_shooter/components/player.dart';
import 'package:flame_space_shooter/components/score.dart';
import 'package:flame_space_shooter/components/watermark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SpaceShooterPage extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Player player;
  int scores = 0;
  int lives = 3;
  bool isGameOver = false;

  @override
  Future<void> onLoad() async {
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('rain.png'),
        ParallaxImageData('rain.png'),
        ParallaxImageData('rain.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5),
    );
    add(AlignComponent(alignment: Anchor.bottomCenter, child: Watermark()));
    add(parallax);

    player = Player();
    add(player);

    add(
      SpawnComponent(
        factory: (index) {
          return Enemy();
        },
        period: 1,
        area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
      ),
    );

    add(
      AlignComponent(
        alignment: Anchor.topRight,
        child: Score(),
      ),
    );

    add(AlignComponent(alignment: Anchor.topLeft, child: Live()));
  }

  @override
  void update(double dt) {
    super.update(dt);
    isGameOver == true
        ? add(
            AlignComponent(
                alignment: Anchor.center,
                child: TextComponent(
                  text: 'Game Over',
                )),
          )
        : null;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }

  void gameOver() {
    isGameOver = true;
    // pauseEngine();
    Future.delayed(const Duration(seconds: 1), () {
      pauseEngine();
    });
  }
}
