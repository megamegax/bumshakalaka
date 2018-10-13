import 'package:bumshakalaka/target/target.dart';

class Compost extends Target {
  @override
  String imagePath = "compost.png";

  @override
  int frameCount;

  @override
  double imageHeight;

  @override
  double imageWidth;

  Compost(double x, double y, {imagePath = 'dog.png', frameCount = 9})
      : super(x, y, imagePath, frameCount);
}
