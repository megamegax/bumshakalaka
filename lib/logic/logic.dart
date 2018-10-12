import 'package:bumshakalaka/logic/food.dart';
import 'package:bumshakalaka/logic/target.dart';

abstract class Logic {
  int totalScore = 0;
  int speed = 10;
  Duration elapsedTime;
  List<Target> targets;
  int earthState;
  void start();
  int feedFoodTarget(Target target, Food food);
  int trashFood(Food food);
  Food getNextFood();
}
