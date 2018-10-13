import 'dart:math';

class SpeedCalculator {
  final double _maxValue;
  final double _minValue;

  static const e_number = 2.71828;

  SpeedCalculator(this._maxValue, this._minValue);

  double calculateSpeed(int score, DateTime startTime) {
    var validateSpeed;
    if (score < _minValue) {
      validateSpeed = _minValue;
    } else {
      validateSpeed = score;
    }
    return max(
        DateTime.now().difference(startTime).inSeconds +
            validateSpeed.toDouble() * e_number,
        _maxValue);
  }
}
