import 'dart:math';
import 'dart:ui';

import 'package:bumshakalaka/config/config.dart';
import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/food/food_provider.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/target/target.dart';

class Coordinates {
  final double x;
  final double y;

  Coordinates(this.x, this.y);
}

class GameLogic extends Logic {
  final Config _config;

  final FoodProvider _foodProvider;

  final Random _random;

  final Map<String, Coordinates> _targetCoordinates = {
    "dumpster": new Coordinates(190.0, 550.0),
    "dog": new Coordinates(300.0, 550.0),
    "fridge": new Coordinates(0.0, 550.0),
    "compost": new Coordinates(100.0, 550.0)
  };

  GameLogic(this._config, this._foodProvider, this._random);

  @override
  double foodLatency() {
    return _random.nextDouble() + 2.0;
  }

  @override
  int feedFoodTarget(Target target, Food food) {
    return 0;
  }

  @override
  Food getNextFood(bool Function(Food food) destroyAction) {
    return _foodProvider.getFood(10.0, destroyAction);
  }

  @override
  int missedFood(Food food) {
    // TODO: implement missedFood
    return null;
  }

  @override
  void start(Size screenSize) {
    this.targets = _config.targetConfigs
        .map((tc) => new Target(
            tc.name,
            _targetCoordinates[tc.name],
            tc.imagePath,
            tc.frameCount,
            tc.imageWidth.toDouble(),
            tc.imageHeight.toDouble()))
        .toList();

    this.screenSize = screenSize;
    this._foodProvider.screenWidth = screenSize.width;
  }
}
