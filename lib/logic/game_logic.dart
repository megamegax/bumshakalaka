import 'dart:math';
import 'dart:ui';

import 'package:bumshakalaka/config/config.dart';
import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/food/food_dto.dart';
import 'package:bumshakalaka/food/food_provider.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/logic/speed_calculator.dart';
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
  SpeedCalculator _speedCalculator;
  DateTime _startTime;

  Map<String, Coordinates> _targetCoordinates = {};

  GameLogic(
      this._config, this._foodProvider, this._random, this._speedCalculator);

  @override
  double foodLatency() {
    return _random.nextDouble() + 1.3;
  }

  @override
  int feedFoodTarget(Target target, Food food) {
    var targetString = _foodProvider.getTarget(food.imagePath);
    var goodTarget =
        targets.firstWhere((target) => target.name == targetString);
    if (goodTarget == target) {
      totalScore++;
      return 1;
    } else {
      totalScore--;
      return -1;
    }
  }

  @override
  Food getNextFood(bool Function(Food food) destroyAction) {
    var speed = _speedCalculator.calculateSpeed(totalScore, _startTime);
    var food = _foodProvider.getFood();
    return _createFood(food, speed, destroyAction);
  }

  @override
  int missedFood(Food food) {
    totalScore--;
    return -1;
  }

  @override
  void start(Size screenSize) {
    this.screenSize = screenSize;
    _startTime = DateTime.now();
    _targetCoordinates = {
      "dumpster": new Coordinates(190.0, screenSize.height - 150.0),
      "dog": new Coordinates(260.0, screenSize.height - 210.0),
      "fridge": new Coordinates(90.0, screenSize.height - 280.0),
      "compost": new Coordinates(-30.0, screenSize.height - 150)
    };

    this.targets = _config.targetConfigs
        .map((tc) => new Target(
            tc.name,
            _targetCoordinates[tc.name],
            tc.imagePath,
            tc.frameCount,
            tc.imageWidth.toDouble(),
            tc.imageHeight.toDouble()))
        .toList();
  }

  Food _createFood(
      FoodDto food, double speed, bool Function(Food food) destroyAction) {
    double xCoord =
        _random.nextDouble() * (this.screenSize.width - food.imageWidth);
    return Food(xCoord, 0.0, food.imagePath, speed, food.imageWidth.toDouble(),
        food.imageHeight.toDouble(), food.frameCount, destroyAction);
  }
}
