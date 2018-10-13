import 'package:bumshakalaka/food/food.dart';
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

  static Food createFood(
      {double x = 15.0,
      double y = 20.0,
      String imagePath = "red_apple.png",
      double speed = 10.0,
      double imageWidth = 64.0,
      double imageHeight = 64.0,
      frameCount = 1,
      bool Function(Food food) destroyAction}) {
    var action = destroyAction == null ? destroyAction : (food) => false;
    return new Food(
        x, y, imagePath, speed, imageWidth, imageHeight, frameCount, action);
  }
}
