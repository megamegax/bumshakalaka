import 'dart:ui';

import 'package:bumshakalaka/logic/game_logic.dart';
import 'package:bumshakalaka/util/assert.dart';
import 'package:flame/components.dart';

class Target extends SpriteAnimationComponent {
  String name;
  Image imageInstance;
  double animationSpeed;
  int frameCount;
  double imageWidth;
  double imageHeight;

  Target(this.name, Coordinates c, this.imageInstance, frameCount,
      double imageWidth, double imageHeight)
      : super.fromFrameData(
            imageInstance,
            SpriteAnimationData.sequenced(
                stepTime: 0.05,
                amount: frameCount,
                textureSize: Vector2(imageWidth -20, imageHeight))) {
    Assert.notNull(c.x, 'X must not be null!');
    Assert.notNull(c.y, 'Y must not be null!');
    Assert.notNull(frameCount, 'frameCount must not be null!');
    this.x = c.x;
    this.y = c.y;
    this.imageInstance = imageInstance;
    this.frameCount = frameCount;
    this.imageHeight = imageHeight;
    this.imageWidth = imageWidth;
    this.width = imageWidth;
    this.height = imageHeight;
    this.animationSpeed = 0.75;
    this.animation.stepTime = animationSpeed / 7;
  }

  @override
  int get priority => 1;

  @override
  bool toDestroy = false;
}
