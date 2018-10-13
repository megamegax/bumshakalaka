import 'package:bumshakalaka/util/assert.dart';
import 'package:flame/components/animation_component.dart';

class Food extends AnimationComponent {
  String imagePath;
  double speed;
  double animationSpeed;
  int frameCount;
  double imageWidth;
  double imageHeight;
  bool isTouched;
  bool Function(Food food) destroyAction;

  bool toDestroy = false;

  Food(double x, double y, this.imagePath, this.speed, this.imageWidth,
      this.imageHeight, frameCount, this.destroyAction)
      : super.sequenced(imageWidth, imageHeight, imagePath, 1,
            textureWidth: imageWidth, textureHeight: imageHeight) {
    Assert.notNull(x, 'X must not be null!');
    Assert.notNull(y, 'Y must not be null!');
    Assert.notNull(frameCount, 'frameCount must not be null!');
    this.x = x;
    this.y = y;
    this.isTouched = false;
    this.animationSpeed = 0.97;
    this.frameCount = frameCount;
    this.animation.stepTime = animationSpeed / 7;
  }

  @override
  bool destroy() {
    if (destroyAction != null) {
      return destroyAction(this);
    } else {
      return false;
    }
  }

  @override
  void update(double t) {
    if (!isTouched) {
      y += t * speed;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Food &&
          runtimeType == other.runtimeType &&
          imagePath == other.imagePath &&
          speed == other.speed &&
          animationSpeed == other.animationSpeed &&
          frameCount == other.frameCount &&
          imageWidth == other.imageWidth &&
          imageHeight == other.imageHeight &&
          isTouched == other.isTouched;

  @override
  int get hashCode =>
      imagePath.hashCode ^
      speed.hashCode ^
      animationSpeed.hashCode ^
      frameCount.hashCode ^
      imageWidth.hashCode ^
      imageHeight.hashCode ^
      isTouched.hashCode;

  @override
  String toString() {
    return 'Food{imagePath: $imagePath, speed: $speed, animationSpeed: $animationSpeed, frameCount: $frameCount, imageWidth: $imageWidth, imageHeight: $imageHeight, isTouched: $isTouched}';
  }
}
