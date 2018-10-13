import 'package:bumshakalaka/target/target.dart';

const FRIDGE_SIZE_X = 128.0;
const FRIDGE_SIZE_Y = 128.0;

class Fridge extends Target {
  Fridge(double x, double y, {imagePath = 'fridge.png', frameCount = 11})
      : super(x, y, imagePath, frameCount, FRIDGE_SIZE_X, FRIDGE_SIZE_Y);
}
