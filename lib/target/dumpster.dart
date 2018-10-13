import 'package:bumshakalaka/target/target.dart';

const TRASHBIN_SIZE_X = 128.0;
const TRASHBIN_SIZE_Y = 128.0;

class Dumpster extends Target {
  Dumpster(double x, double y, {imagePath = 'dumpster.png', frameCount = 7})
      : super(x, y, imagePath, frameCount, TRASHBIN_SIZE_X, TRASHBIN_SIZE_Y);
}
