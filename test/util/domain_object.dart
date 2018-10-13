import 'package:bumshakalaka/logic/game_logic.dart';
import 'package:bumshakalaka/target/target.dart';

class DomainObject {
  static Target createTarget(
      {String name = "dog",
      double x = 15.0,
      double y = 20.0,
      String imagePath = "dog.png",
      int frameCount = 7,
      double imageWidth = 128.0,
      double imageHeight = 128.0}) {
    return new Target(name, new Coordinates(x, y), imagePath, frameCount,
        imageWidth, imageHeight);
  }
}
