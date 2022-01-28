import 'dart:ui';

import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/target/target.dart';
import 'package:flame/assets.dart';
import 'package:flame/components.dart';

abstract class Logic {
  int speed;
  Duration elapsedTime;
  List<Target> targets;
  int earthState;
  Vector2 screenSize;

  double foodLatency();

  void start(Vector2 screenSize, Images images);

  void gameOver();

  int feedFoodTarget(Target target, Food food);

  int missedFood(Food food);

  Future<Food> getNextFood(
      bool Function(Food food) destroyAction, Images images);

  int getTotalScore();

  int getUnsuccessfulPlacementCount();

  int getSuccessfulPlacementCount();

  String getWindowName();

  double getSuccessfulPercentageOfPlacements();
}
