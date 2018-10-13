import 'package:bumshakalaka/target/target.dart';

class Compost extends Target {
  @override
  String imagePath = "compost.png";

  @override
  int frameCount;

  @override
  int imageHeight;

  @override
  int imageWidth;

  Compost(double x, double y, imagePath, frameCount)
      : super(x, y, imagePath, frameCount);
}
