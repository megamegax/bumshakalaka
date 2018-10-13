import 'package:bumshakalaka/assert.dart';
import 'package:flame/components/animation_component.dart';

class Food extends AnimationComponent {
  String imagePath;
  double speed;
  double animationSpeed;
  int frameCount;
  double imageWidth;
  double imageHeight;
  double textureWidth;
  double textureHeight;
  bool isTouched;

  Food(
      double x,
      double y,
      this.imagePath,
      this.speed,
      this.animationSpeed,
      this.imageWidth,
      this.imageHeight,
      this.textureWidth,
      this.textureHeight,
      frameCount)
      : super.sequenced(imageWidth, imageHeight, imagePath, 1,
            textureWidth: textureWidth, textureHeight: textureHeight) {
    Assert.notNull(x, 'X must not be null!');
    Assert.notNull(y, 'Y must not be null!');
    Assert.notNull(frameCount, 'frameCount must not be null!');
    this.x = x;
    this.y = y;
    this.isTouched = false;
    this.frameCount = frameCount;
    this.animation.stepTime = animationSpeed / 7;
  }

  @override
  void update(double t) {
    if (!isTouched) {
      y += t * speed;
    }
  }
}
