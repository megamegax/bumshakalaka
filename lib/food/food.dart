import 'package:bumshakalaka/assert.dart';
import 'package:flame/components/animation_component.dart';

class Food extends AnimationComponent {
  String imagePath;
  double speed = 10;
  double animationSpeed = 0.75;
  int animationCount = 1;
  double imageWidth = 64.0;
  double imageHeight = 64.0;
  bool isTouched = false;

  Food(double x, double y, imagePath, animationCount)
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

  @override
  void update(double t) {
    if (!isTouched) {
      y += t * speed;
    }
  }
}
