import 'package:bumshakalaka/assert.dart';
import 'package:flame/components/animation_component.dart';

abstract class Target extends AnimationComponent {
  String imagePath;
  double animationSpeed = 0.75;
  int animationCount = 1;
  int imageWidth = 100;
  int imageHeight = 100;
  Target(double x, double y, imagePath, animationCount)
      : super.sequenced(64.0, 64.0, imagePath, 1,
            textureWidth: 64.0, textureHeight: 64.0) {
    Assert.notNull(x, 'X must not be null!');
    Assert.notNull(y, 'Y must not be null!');
    Assert.notNull(animationCount, 'animationCount must not be null!');
    this.x = x;
    this.y = y;
    this.imagePath = imagePath;
    this.animationCount = animationCount;
    this.animation.stepTime = animationSpeed / 7;
  }
}
