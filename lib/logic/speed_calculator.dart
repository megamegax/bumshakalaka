class SpeedCalculator {
  double calculateSpeed(int score, DateTime startTime) {
    var validateSpeed;§§
    if (score < 5) {
      validateSpeed = 5;
    }
    return DateTime.now().difference(startTime).inSeconds *
        validateSpeed.toDouble();
  }
}
