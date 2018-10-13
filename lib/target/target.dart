import 'package:bumshakalaka/logic/game_logic.dart';
import 'package:bumshakalaka/util/assert.dart';
import 'package:flame/components/animation_component.dart';

class Target extends AnimationComponent {
  String name;
  String imagePath;
  double animationSpeed;
  int frameCount;
  double imageWidth;
  double imageHeight;

  Target(this.name, Coordinates c, imagePath, frameCount, double imageWidth,
      double imageHeight)
      : super.sequenced(imageWidth, imageHeight, imagePath, frameCount,
            textureWidth: imageWidth, textureHeight: imageHeight) {
    Assert.notNull(c.x, 'X must not be null!');
    Assert.notNull(c.y, 'Y must not be null!');
    Assert.notNull(frameCount, 'frameCount must not be null!');
    this.x = c.x;
    this.y = c.y;
    this.imagePath = imagePath;
    this.frameCount = frameCount;
    this.imageHeight = imageHeight;
    this.imageWidth = imageWidth;
    this.animationSpeed = 0.75;
    this.animation.stepTime = animationSpeed / 7;
  }
}
