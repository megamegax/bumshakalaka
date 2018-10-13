import 'dart:math';

import 'package:bumshakalaka/food/food_dto.dart';

class FoodProvider {
  final List<FoodDto> _foods;
  final Random _random;

  FoodProvider(this._foods, this._random);

  FoodDto getFood() {
    return _foods[_random.nextInt(_foods.length)];
  }

  String getTarget(FoodDto food) {
    return _foods
        .firstWhere((foodFc) => food.imagePath == foodFc.imagePath)
        .target;
  }
}
