import 'package:bumshakalaka/assert.dart';
import 'package:flame/components/animation_component.dart';

abstract class Target extends AnimationComponent {
  String imagePath;
  double animationSpeed = 0.75;
  int frameCount = 1;
  double imageWidth;
  double imageHeight;

  Target(double x, double y, imagePath, frameCount, double imageWidth,
      double imageHeight)
      : super.sequenced(imageWidth, imageHeight, imagePath, frameCount,
            textureWidth: imageWidth, textureHeight: imageHeight) {
    Assert.notNull(x, 'X must not be null!');
    Assert.notNull(y, 'Y must not be null!');
    Assert.notNull(frameCount, 'frameCount must not be null!');
    this.x = x;
    this.y = y;
    this.imagePath = imagePath;
    this.frameCount = frameCount;
    this.imageHeight = imageHeight;
    this.imageWidth = imageWidth;
    this.animation.stepTime = animationSpeed / 7;
  }
}
