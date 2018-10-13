class SpeedCalculator {
  double calculateSpeed(int score, Duration elapsedTime) {
    return elapsedTime.inSeconds * score.toDouble();
  }
}
