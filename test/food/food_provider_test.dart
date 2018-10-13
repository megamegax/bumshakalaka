import 'dart:math';

import 'package:bumshakalaka/config/food_config.dart';
import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/food/food_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RandomMock extends Mock implements Random {}

void main() {
  group("FoodProvider", () {
    test("should return a food", () {
      var randomMock = new RandomMock();
      var imagePath = "apple.png";
      var frameCount = 3;
      var imageWidth = 250;
      var imageHeight = 270;
      var foodConfig = [
        new FoodConfig("", "", 1, 240, 240),
        new FoodConfig(imagePath, "", frameCount, imageWidth, imageHeight)
      ];
      var screenWidth = 345.0;
      var speed = 5000.0;
      var xCoord = 3.0;
      when(randomMock.nextDouble()).thenReturn(xCoord);
      when(randomMock.nextInt(foodConfig.length)).thenReturn(1);
      var destroyAction = (food) {
        return false;
      };
      var expectedFood = new Food(
          xCoord,
          0.0,
          imagePath,
          speed,
          imageWidth.toDouble(),
          imageHeight.toDouble(),
          frameCount,
          destroyAction);

      var foodProvider = new FoodProvider(foodConfig, randomMock);
      foodProvider.screenWidth = screenWidth;

      expect(foodProvider.getFood(speed, destroyAction), expectedFood);
    });

//    test("should return the target of a food", () {
//      var randomMock = new RandomMock();
//      var imagePath = "apple.png";
//      var target = "fridge";
//      var frameCount = 3;
//      var imageWidth = 250;
//      var imageHeight = 270;
//      var foodConfig = [
//        new FoodConfig(imagePath, target, frameCount, imageWidth, imageHeight)
//      ];
//
//      var foodProvider = new FoodProvider(foodConfig, 345, randomMock);
//
//      var food = new Food(0.0, 0.0, imagePath, 5000.0, imageWidth.toDouble(),
//          imageHeight.toDouble(), frameCount);
//
//      expect(foodProvider.getTarget(food), target);
//    });
  });
}
