import 'package:bumshakalaka/food/food_dto.dart';
import 'package:bumshakalaka/target/target_dto.dart';

class Config {
  List<FoodDto> foodConfigs;
  List<TargetDto> targetConfigs;

  Config(this.foodConfigs, this.targetConfigs);

  Config.fromJson(Map<String, dynamic> configJson) {
    foodConfigs = [];
    targetConfigs = [];
    configJson["foods"].forEach((food) {
      foodConfigs.add(new FoodDto.fromJson(food));
    });

    configJson["targets"].forEach((target) {
      targetConfigs.add(new TargetDto.fromJson((target)));
    });
  }
}
