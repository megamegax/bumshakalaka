import 'dart:math';

import 'package:bumshakalaka/config/food_config.dart';
import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/target/target.dart';

class FoodProvider {
  final List<FoodConfig> _foods;
  final Random _random;

  FoodProvider(this._foods, this._random);

  Food getFood(double speed, double screenWidth,
      bool Function(Food food) destroyAction) {
    FoodConfig foodConfig = _foods[_random.nextInt(_foods.length)];
    double xCoord = _random.nextDouble() * screenWidth;
    return Food(
        xCoord,
        0.0,
        foodConfig.imagePath,
        speed,
        foodConfig.imageWidth.toDouble(),
        foodConfig.imageHeight.toDouble(),
        foodConfig.frameCount,
        destroyAction);
  }

  Target getTarget(Food food) {
    return null;
  }
}
