import 'dart:math';
import 'dart:ui';

import 'package:bumshakalaka/config/config.dart';
import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/target/target.dart';

class Coordinates {
  final double x;
  final double y;

  Coordinates(this.x, this.y);
}

class GameLogic extends Logic {
  Config config;

  final Map<String, Coordinates> _targetCoordinates = {
    "dumpster": new Coordinates(190.0, 550.0),
    "dog": new Coordinates(300.0, 550.0),
    "fridge": new Coordinates(0.0, 550.0),
    "compost": new Coordinates(100.0, 550.0)
  };

  GameLogic(this.config, this.foodLatency);

  @override
  double foodLatency;

  @override
  int feedFoodTarget(Target target, Food food) {
    return 0;
  }

  @override
  Food getNextFood(bool Function(Food food) destroyAction) {
    Random random = new Random();
    var x = random.nextInt(screenSize.width.toInt());
    return new Food(
        x.toDouble(), 0.0, 'red_apple.png', 10.0, 64.0, 64.0, 1, destroyAction);
  }

  @override
  int missedFood(Food food) {
    // TODO: implement missedFood
    return null;
  }

  @override
  void start(Size screenSize) {
    this.targets = config.targetConfigs.map((tc) => new Target(
        tc.name,
        _targetCoordinates[tc.name],
        tc.imagePath,
        tc.frameCount,
        tc.imageWidth.toDouble(),
        tc.imageHeight.toDouble()));

    this.screenSize = screenSize;
  }
}
