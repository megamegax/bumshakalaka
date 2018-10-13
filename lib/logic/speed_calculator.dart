class SpeedCalculator {
  double calculateSpeed(int score, DateTime startTime) {
    return startTime.difference(DateTime.now()).inSeconds * score.toDouble();
  }
}
