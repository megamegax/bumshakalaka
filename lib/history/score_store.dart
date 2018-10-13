class ScoreStore {
  int _totalScore = 0;
  int _successfulPlacement = 0;
  int _unsuccessfulPlacement = 0;

  ScoreStore();

  void incrementScore(int points) {
    _successfulPlacement++;
    _totalScore += points;
  }

  void decrementScore(int points) {
    _unsuccessfulPlacement++;
    _totalScore -= points;
  }

  int retrieveTotalScore() {
    return _totalScore;
  }

  double retrieveSuccessfulPlacementPercentage() {
    return _successfulPlacement /
        (_unsuccessfulPlacement + _successfulPlacement) *
        100;
  }

  double retrieveUnsuccessfulPlacementPercentage() {
    return _unsuccessfulPlacement /
        (_successfulPlacement + _unsuccessfulPlacement) *
        100;
  }

  int retrieveSuccessfulPlacement() {
    return _successfulPlacement;
  }

  int retrieveUnsuccessfulPlacement() {
    return _unsuccessfulPlacement;
  }
}
