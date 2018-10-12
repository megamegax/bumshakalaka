import 'package:bumshakalaka/target/target.dart';

class Fridge extends Target {
  @override
  String imagePath = "fridge.png";

  @override
  int animationCount;

  @override
  int imageHeight;

  @override
  int imageWidth;

  Fridge(double x, double y, imagePath, animationCount)
      : super(x, y, imagePath, animationCount);
}
