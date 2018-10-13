import 'package:bumshakalaka/target/target.dart';

const COMPOST_SIZE_X = 122.0;
const COMPOST_SIZE_Y = 128.0;

class Compost extends Target {
  Compost(double x, double y, {imagePath = 'compost.png', frameCount = 8})
      : super(x, y, imagePath, frameCount, COMPOST_SIZE_X, COMPOST_SIZE_Y);
}
