import 'package:bumshakalaka/config/food_config.dart';
import 'package:bumshakalaka/config/target_config.dart';

class Config {
  List<FoodConfig> foodConfigs;
  List<TargetConfig> targetConfigs;

  Config(this.foodConfigs, this.targetConfigs);

  Config.fromJson(Map<String, dynamic> configJson) {
    foodConfigs = [];
    targetConfigs = [];
    configJson["foods"].forEach((food) {
      foodConfigs.add(new FoodConfig.fromJson(food));
    });

    configJson["targets"].forEach((target) {
      targetConfigs.add(new TargetConfig.fromJson((target)));
    });
  }
}
