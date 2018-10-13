import 'dart:math';
import 'dart:ui';

import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/target/compost.dart';
import 'package:bumshakalaka/target/dog.dart';
import 'package:bumshakalaka/target/dumpster.dart';
import 'package:bumshakalaka/target/fridge.dart';
import 'package:bumshakalaka/target/target.dart';

class GameLogic extends Logic {
  @override
  double foodLatency = 1;

  @override
  int feedFoodTarget(Target target, Food food) {
    print("feedFoodTarget");
    return 0;
  }

  @override
  Food getNextFood(bool Function(Food food) destroyAction) {
    Random random = new Random();
    var x = random.nextInt(screenSize.width.toInt());
    return new Food(
        x.toDouble(), 0, 'red_apple.png', 10, 64.0, 64.0, 1, destroyAction);
  }

  @override
  int missedFood(Food food) {
    print("Missed food");
    totalScore -= 1;
    return null;
  }

  @override
  void start(Size screenSize) {
    this.screenSize = screenSize;
    targets = [];
    targets.add(new Dumpster(190.0, 550.0));
    targets.add(new Dog(300.0, 550.0));
    targets.add(new Fridge(0.0, 550.0));
    targets.add(new Compost(100.0, 550.0));
  }
}
