import 'dart:math';
import 'dart:ui';

import 'package:bumshakalaka/config/config.dart';
import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/food/food_dto.dart';
import 'package:bumshakalaka/food/food_provider.dart';
import 'package:bumshakalaka/history/score_store.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/logic/speed_calculator.dart';
import 'package:bumshakalaka/target/target.dart';
import 'package:flame/assets.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

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
  ScoreStore _scoreStore;

  GameLogic(this._config, this._foodProvider, this._random,
      this._speedCalculator, this._scoreStore);

  @override
  double foodLatency() {
    return _random.nextDouble() + 1.7;
  }

  @override
  int feedFoodTarget(Target target, Food food) {
    var targetString = _foodProvider.getTarget(food.imageName);
    var goodTarget =
        targets.firstWhere((target) => target.name == targetString);
    if (goodTarget == target) {
      _scoreStore.incrementScore(1);
      return 1;
    } else {
      _scoreStore.decrementScore(1);
      return -1;
    }
  }

  @override
  Future<Food> getNextFood(
      bool Function(Food food) destroyAction, Images images) async {
    var speed = _speedCalculator.calculateSpeed(
        _scoreStore.retrieveTotalScore(), _startTime);

    var food = _foodProvider.getFood();

    return await _createFood(food, speed, destroyAction, images);
  }

  @override
  int missedFood(Food food) {
    _scoreStore.decrementScore(1);
    return -1;
  }

  @override
  void start(Vector2 screenSize, Images images) async {
    this.screenSize = screenSize;
    _startTime = DateTime.now();
    Map<String, Coordinates> targetCoordinates = {
      "dumpster": new Coordinates(190.0, screenSize.y - 150.0),
      "dog": new Coordinates(screenSize.x * 0.6, screenSize.y - 210.0),
      "fridge": new Coordinates(screenSize.x * 0.25, screenSize.y - 250.0),
      "compost": new Coordinates(20.0, screenSize.y - 130)
    };
    List<Target> mappedTargets = [];
    for (var tc in _config.targetConfigs) {
      final target = new Target(
          tc.name,
          targetCoordinates[tc.name],
          await images.load(tc.imagePath),
          tc.frameCount,
          tc.imageWidth.toDouble(),
          tc.imageHeight.toDouble());

      mappedTargets.add(target);
    }

    this.targets = mappedTargets;
  }

  @override
  int getTotalScore() {
    return _scoreStore.retrieveTotalScore();
  }

  Future<Food> _createFood(FoodDto food, double speed,
      bool Function(Food food) destroyAction, Images images) async {
    double xCoord =
        _random.nextDouble() * (this.screenSize.x - food.imageWidth);
    return Food(
        xCoord,
        0.0,
        food.imagePath,
        await Sprite.load(food.imagePath, srcSize: Vector2.all(74)),
        speed,
        food.imageWidth.toDouble(),
        food.imageHeight.toDouble(),
        food.frameCount,
        destroyAction);
  }

  @override
  double getSuccessfulPercentageOfPlacements() {
    return _scoreStore.retrieveSuccessfulPlacementPercentage();
  }

  @override
  int getUnsuccessfulPlacementCount() {
    return _scoreStore.retrieveUnsuccessfulPlacement();
  }

  @override
  String getWindowName() {
    int unsuccessfulPlacements = _scoreStore.retrieveUnsuccessfulPlacement();
    if (unsuccessfulPlacements < 20) {
      return "window.png";
    } else if (unsuccessfulPlacements < 45) {
      return "window_dry_tree.png";
    } else {
      return "window_moon.png";
    }
  }

  @override
  int getSuccessfulPlacementCount() {
    return _scoreStore.retrieveSuccessfulPlacement();
  }

  @override
  void gameOver() {}
}
