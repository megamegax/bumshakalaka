import 'dart:math';

import 'package:bumshakalaka/food/food_dto.dart';
import 'package:bumshakalaka/food/food_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RandomMock extends Mock implements Random {}

void main() {
  group("FoodProvider", () {
    test("should return a food", () {
      var randomMock = new RandomMock();
      var expectedFoodDto = new FoodDto("green_apple.png", "", 3, 250, 270);
      var foodConfig = [new FoodDto("", "", 1, 240, 240), expectedFoodDto];
      var xCoord = 3.0;
      when(randomMock.nextDouble()).thenReturn(xCoord);
      when(randomMock.nextInt(foodConfig.length)).thenReturn(1);

      var foodProvider = new FoodProvider(foodConfig, randomMock);

      expect(foodProvider.getFood(), expectedFoodDto);
    });

    test("should return the target of a food", () {
      var target = "fridge";
      var foodDto = new FoodDto("green_apple.png", target, 3, 250, 270);

      var foodProvider = new FoodProvider([foodDto], new RandomMock());

      expect(foodProvider.getTarget(foodDto), target);
    });
  });
}
