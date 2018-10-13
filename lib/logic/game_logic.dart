import 'dart:math';
import 'dart:ui';

import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/target/dog.dart';
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
  Food getNextFood() {
    Random random = new Random();
    var x = random.nextInt(screenSize.width.toInt());
    return new Food(x.toDouble(), 0, 'red_apple.png', 10, 64.0, 64.0, 1);
  }

  @override
  int missedFood(Food food) {
    // TODO: implement missedFood
    return null;
  }

  @override
  void start(Size screenSize) {
    this.screenSize = screenSize;
    targets = [];
    targets.add(new Dog(0, 0));
  }
}
