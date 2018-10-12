import 'package:bumshakalaka/target/target.dart';

class Compost extends Target {
  @override
  String imagePath = "compost.png";

  @override
  int animationCount;

  @override
  int imageHeight;

  @override
  int imageWidth;

  Compost(double x, double y, imagePath, animationCount)
      : super(x, y, imagePath, animationCount);
}
