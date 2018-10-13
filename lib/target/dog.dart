import 'package:bumshakalaka/target/target.dart';

const DOG_SIZE_X = 110.0;
const DOG_SIZE_Y = 128.0;

class Dog extends Target {
  @override
  String imagePath = "dog.png";

  @override
  int frameCount;

  @override
  double imageHeight = 128.0;

  @override
  double imageWidth = 110.0;

  Dog(double x, double y, {imagePath = 'dog.png', frameCount = 9})
      : super(x, y, imagePath, frameCount);
}
