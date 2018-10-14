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
import 'package:firebase_analytics/firebase_analytics.dart';

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
  FirebaseAnalytics analytics;

  GameLogic(this._config, this._foodProvider, this._random,
      this._speedCalculator, this._scoreStore, this.analytics);

  @override
  double foodLatency() {
    return _random.nextDouble() + 1.7;
  }

  @override
  int feedFoodTarget(Target target, Food food) {
    var targetString = _foodProvider.getTarget(food.imagePath);
    var goodTarget =
        targets.firstWhere((target) => target.name == targetString);
    if (goodTarget == target) {
      _scoreStore.incrementScore(1);
      analytics.logEvent(name: "foodMatch");
      return 1;
    } else {
      analytics.logEvent(name: "foodDismatch");
      _scoreStore.decrementScore(1);
      return -1;
    }
  }

  @override
  Food getNextFood(bool Function(Food food) destroyAction) {
    var speed = _speedCalculator.calculateSpeed(
        _scoreStore.retrieveTotalScore(), _startTime);
    var food = _foodProvider.getFood();
    return _createFood(food, speed, destroyAction);
  }

  @override
  int missedFood(Food food) {
    _scoreStore.decrementScore(1);
    analytics.logEvent(name: "missedFood");
    return -1;
  }

  @override
  void start(Size screenSize) {
    this.screenSize = screenSize;
    _startTime = DateTime.now();
    Map<String, Coordinates> targetCoordinates = {
      "dumpster": new Coordinates(190.0, screenSize.height - 150.0),
      "dog": new Coordinates(260.0, screenSize.height - 210.0),
      "fridge": new Coordinates(110.0, screenSize.height - 250.0),
      "compost": new Coordinates(20.0, screenSize.height - 110)
    };

    this.targets = _config.targetConfigs
        .map((tc) => new Target(
            tc.name,
            targetCoordinates[tc.name],
            tc.imagePath,
            tc.frameCount,
            tc.imageWidth.toDouble(),
            tc.imageHeight.toDouble()))
        .toList();
  }

  @override
  int getTotalScore() {
    return _scoreStore.retrieveTotalScore();
  }

  Food _createFood(
      FoodDto food, double speed, bool Function(Food food) destroyAction) {
    double xCoord =
        _random.nextDouble() * (this.screenSize.width - food.imageWidth);
    return Food(xCoord, 0.0, food.imagePath, speed, food.imageWidth.toDouble(),
        food.imageHeight.toDouble(), food.frameCount, destroyAction);
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
  void gameOver() {
    analytics.logPostScore(score: _scoreStore.retrieveTotalScore());
  }
}
