import 'package:bumshakalaka/config/config.dart';
import 'package:bumshakalaka/config/food_config.dart';
import 'package:bumshakalaka/config/target_config.dart';
import 'package:test/test.dart';

void main() {
  group("Config", () {
    test("parse json", () {
      List<Map<String, dynamic>> foodConfig = [
        new FoodConfig("green_apple.png", "fridge", 1, 240, 240).toJson(),
        new FoodConfig("red_apple.png", "fridge", 3, 250, 250).toJson()
      ];
      List<Map<String, dynamic>> targetConfig = [
        new TargetConfig("fridge.png", "fridge", 1, 230, 230).toJson(),
        new TargetConfig("dumpster.png", "dumpster", 2, 220, 220).toJson()
      ];
      var jsonMap = {"foods": foodConfig, "targets": targetConfig};

      var config = Config.fromJson(jsonMap);

      expect(config.foodConfigs, [
        new FoodConfig("green_apple.png", "fridge", 1, 240, 240),
        new FoodConfig("red_apple.png", "fridge", 3, 250, 250)
      ]);
      expect(config.targetConfigs, [
        new TargetConfig("fridge.png", "fridge", 1, 230, 230),
        new TargetConfig("dumpster.png", "dumpster", 2, 220, 220)
      ]);
    });
  });
}
