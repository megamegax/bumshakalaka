import 'dart:ui';

import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/target/target.dart';

abstract class Logic {
  int totalScore = 0;
  int speed;
  Duration elapsedTime;
  List<Target> targets;
  int earthState;
  Size screenSize;

  double foodLatency();

  void start(Size screenSize);

  int feedFoodTarget(Target target, Food food);

  int missedFood(Food food);

  Food getNextFood(bool Function(Food food) destroyAction);
}
