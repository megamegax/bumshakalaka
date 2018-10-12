import 'package:bumshakalaka/target/target.dart';

class Dumpster extends Target {
  @override
  String imagePath = "dumpster.png";

  @override
  int animationCount;

  @override
  int imageHeight;

  @override
  int imageWidth;

  Dumpster(double x, double y, imagePath, animationCount)
      : super(x, y, imagePath, animationCount);
}
