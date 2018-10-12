import 'package:bumshakalaka/config/config.dart';
import 'package:bumshakalaka/config/food_config.dart';
import 'package:bumshakalaka/config/target_config.dart';
import 'package:test/test.dart';

void main() {
  group("Main", () {
    test("should disableAudioLogs", () {
      var foodConfig = [
        new FoodConfig("green_apple.png", "fridge", 1, 240, 240),
        new FoodConfig("red_apple.png", "fridge", 3, 250, 250)
      ];
      var targetConfig = [
        new TargetConfig("fridge", 1, 230, 230),
        new TargetConfig("dumpster", 2, 220, 220)
      ];
      var json = Map.of({"foods": foodConfig, "targets": targetConfig});

      var config = new Config.fromJson(json);

      expect(config.foodConfig, foodConfig);
      expect(config.targetConfig, targetConfig);
    });
  });
}
