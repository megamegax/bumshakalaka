import 'package:bumshakalaka/config/food_config.dart';
import 'package:bumshakalaka/config/target_config.dart';

class Config {
  final List<FoodConfig> foodConfig;
  final List<TargetConfig> targetConfig;

  Config(this.foodConfig, this.targetConfig);

  Config.fromJson(Map<String, dynamic> json)
      : foodConfig = (json["foods"] as List)
            .map((json) => new FoodConfig.fromJson(json))
            .toList(),
        targetConfig = (json["targets"] as List)
            .map((json) => new TargetConfig.fromJson((json)))
            .toList();
}
