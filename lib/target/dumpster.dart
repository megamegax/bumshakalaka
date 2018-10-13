import 'package:bumshakalaka/target/target.dart';

class Dumpster extends Target {
  @override
  String imagePath = "dumpster.png";

  @override
  int frameCount;

  @override
  double imageHeight;

  @override
  double imageWidth;

  Dumpster(double x, double y, {imagePath = 'dog.png', frameCount = 9})
      : super(x, y, imagePath, frameCount);
}
