import 'package:flame/components/component.dart';

class Window extends SpriteComponent {
  bool toDestroy = false;
  String imagePath;

  Window(double width, double height, this.imagePath)
      : super.rectangle(width, height, imagePath);

  @override
  bool destroy() {
    return toDestroy;
  }
}
