import 'package:bumshakalaka/target/target.dart';

class Dumpster extends Target {
  @override
  String imagePath = "dumpster.png";

  @override
  int frameCount;

  @override
  int imageHeight;

  @override
  int imageWidth;

  Dumpster(double x, double y, imagePath, frameCount)
      : super(x, y, imagePath, frameCount);
}
