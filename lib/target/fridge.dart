import 'package:bumshakalaka/target/target.dart';

class Fridge extends Target {
  @override
  String imagePath = "fridge.png";

  @override
  int frameCount;

  @override
  double imageHeight;

  @override
  double imageWidth;

  Fridge(double x, double y, {imagePath = 'dog.png', frameCount = 9})
      : super(x, y, imagePath, frameCount);
}
