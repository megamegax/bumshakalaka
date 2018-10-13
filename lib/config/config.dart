import 'package:bumshakalaka/config/food_config.dart';
import 'package:bumshakalaka/config/target_config.dart';

class Config {
  List<FoodConfig> foodConfig;
  List<TargetConfig> targetConfig;

  Config(this.foodConfig, this.targetConfig);

  Config.fromJson(Map<String, dynamic> configJson) {
    //var configJson = json.decode(jsonObject);

    foodConfig = [];
    targetConfig = [];
    configJson["foods"].forEach((food) {
      foodConfig.add(new FoodConfig.fromJson(food));
    });

    configJson["targets"].forEach((json) {
      targetConfig.add(new TargetConfig.fromJson((json)));
    });
  }
}
