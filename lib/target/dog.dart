import 'package:bumshakalaka/target/target.dart';

const DOG_SIZE_X = 110.0;
const DOG_SIZE_Y = 128.0;

class Dog extends Target {
  Dog(double x, double y, {imagePath = 'dog.png', frameCount = 9})
      : super(x, y, imagePath, frameCount, DOG_SIZE_X, DOG_SIZE_Y);
}
