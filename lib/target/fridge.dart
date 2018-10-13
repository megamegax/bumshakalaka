import 'package:bumshakalaka/target/target.dart';

class Fridge extends Target {
  @override
  String imagePath = "fridge.png";

  @override
  int frameCount;

  @override
  int imageHeight;

  @override
  int imageWidth;

  Fridge(double x, double y, imagePath, frameCount)
      : super(x, y, imagePath, frameCount);
}
