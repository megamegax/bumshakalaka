import 'package:flame/components.dart';

class Window extends SpriteComponent {
  bool toDestroy = false;
  String imagePath;

  Window(double width, double height, sprite)
      : super(size: Vector2(width, height), sprite: sprite);
}
