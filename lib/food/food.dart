import 'dart:ui';

import 'package:bumshakalaka/util/assert.dart';
import 'package:flame/components.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Food extends SpriteComponent {
  Sprite sprite;
  String imageName;
  double speed;
  double imageWidth;
  double imageHeight;
  bool isTouched;
  bool Function(Food food) destroyAction;

  bool toDestroy = false;

  Food(double x, double y, this.imageName, this.sprite, this.speed,
      this.imageWidth, this.imageHeight, frameCount, this.destroyAction)
      : super(size: Vector2(imageWidth, imageHeight), sprite: sprite) {
    Assert.notNull(x, 'X must not be null!');
    Assert.notNull(y, 'Y must not be null!');
    Assert.notNull(frameCount, 'frameCount must not be null!');
    this.x = x;
    this.y = y;
    this.isTouched = false;
  }

  @override
  int get priority => 1;

  @override
  bool destroy() {
    if (toDestroy) return true;
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
          speed == other.speed &&
          imageWidth == other.imageWidth &&
          imageHeight == other.imageHeight &&
          isTouched == other.isTouched;

  @override
  int get hashCode =>
      speed.hashCode ^
      imageWidth.hashCode ^
      imageHeight.hashCode ^
      isTouched.hashCode;

  @override
  String toString() {
    return 'Food';
  }
}
