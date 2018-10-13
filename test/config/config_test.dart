import 'package:bumshakalaka/config/config.dart';
import 'package:bumshakalaka/food/food_dto.dart';
import 'package:bumshakalaka/target/target_dto.dart';
import 'package:test/test.dart';

void main() {
  group("Config", () {
    test("parse json", () {
      List<Map<String, dynamic>> foodConfig = [
        new FoodDto("green_apple.png", "fridge", 1, 240, 240).toJson(),
        new FoodDto("red_apple.png", "fridge", 3, 250, 250).toJson()
      ];
      List<Map<String, dynamic>> targetConfig = [
        new TargetDto("fridge.png", "fridge", 1, 230, 230).toJson(),
        new TargetDto("dumpster.png", "dumpster", 2, 220, 220).toJson()
      ];
      var jsonMap = {"foods": foodConfig, "targets": targetConfig};

      var config = Config.fromJson(jsonMap);

      expect(config.foodConfigs, [
        new FoodDto("green_apple.png", "fridge", 1, 240, 240),
        new FoodDto("red_apple.png", "fridge", 3, 250, 250)
      ]);
      expect(config.targetConfigs, [
        new TargetDto("fridge.png", "fridge", 1, 230, 230),
        new TargetDto("dumpster.png", "dumpster", 2, 220, 220)
      ]);
    });
  });
}
