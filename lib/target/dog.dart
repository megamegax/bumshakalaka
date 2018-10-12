import 'package:bumshakalaka/target/target.dart';

class Dog extends Target {
  @override
  String imagePath = "dog.png";

  @override
  int animationCount;

  @override
  int imageHeight;

  @override
  int imageWidth;

  Dog(double x, double y, imagePath, animationCount)
      : super(x, y, imagePath, animationCount);
}
