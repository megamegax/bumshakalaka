import 'package:bumshakalaka/target/target.dart';

class Dog extends Target {
  @override
  String imagePath = "dog.png";

  @override
  int frameCount;

  @override
  int imageHeight;

  @override
  int imageWidth;

  Dog(double x, double y, imagePath, frameCount)
      : super(x, y, imagePath, frameCount);
}
