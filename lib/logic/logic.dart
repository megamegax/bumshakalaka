import 'dart:ui';

import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/target/target.dart';

abstract class Logic {
  int speed;
  Duration elapsedTime;
  List<Target> targets;
  int earthState;
  Size screenSize;

  double foodLatency();

  void start(Size screenSize);

  void gameOver();
  
  int feedFoodTarget(Target target, Food food);

  int missedFood(Food food);

  Food getNextFood(bool Function(Food food) destroyAction);

  int getTotalScore();

  int getUnsuccessfulPlacementCount();

  int getSuccessfulPlacementCount();

  String getWindowName();

  double getSuccessfulPercentageOfPlacements();
}
