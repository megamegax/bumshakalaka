import 'package:bumshakalaka/history/score_store.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class DateTimeMock extends Mock implements DateTime {}

void main() {
  group("ScoreStore", () {
    test("should be able to retrieve total playtime", () {
      var startTimeMock = new DateTimeMock();
      var endTimeMock = new DateTimeMock();
      Duration elapsedDuration = new Duration(minutes: 1, seconds: 6);
      when(startTimeMock.difference(endTimeMock)).thenReturn(elapsedDuration);
      ScoreStore scoreStore = new ScoreStore(startTimeMock);

      Duration actualDuration = scoreStore.retrieveTotalPlaytime(endTimeMock);

      expect(actualDuration, elapsedDuration);
    });

    test("should be able to increment total score", () {
      int points = 1;
      ScoreStore scoreStore = new ScoreStore(new DateTimeMock());

      scoreStore.incrementScore(points);

      int totalScore = scoreStore.retrieveTotalScore();
      expect(totalScore, points);
    });

    test("should be able to decrease  total score", () {
      int points = 1;
      ScoreStore scoreStore = new ScoreStore(new DateTimeMock());

      scoreStore.decrementScore(points);

      int totalScore = scoreStore.retrieveTotalScore();
      expect(totalScore, -1);
    });

    test("should be able retrive percentage of successful interactions ", () {
      int points = 2;
      int negativePoints = 3;
      ScoreStore scoreStore = new ScoreStore(new DateTimeMock());

      scoreStore.incrementScore(points);
      scoreStore.decrementScore(negativePoints);

      double percentage = scoreStore.retrieveSuccessfulPlacementPercentage();
      expect(percentage, 50.0);
    });

    test("should be able retrive percentage of unsuccessful interactions ", () {
      int points = 2;
      int negativePoints = 3;
      ScoreStore scoreStore = new ScoreStore(new DateTimeMock());

      scoreStore.incrementScore(points);
      scoreStore.decrementScore(negativePoints);
      scoreStore.decrementScore(negativePoints);

      double percentage = scoreStore.retrieveUnsuccessfulPlacementPercentage();
      expect(percentage, 2 / 3 * 100);
    });

    test("should be able retrive number of unsuccessful interactions ", () {
      int points = 2;
      int negativePoints = 3;
      ScoreStore scoreStore = new ScoreStore(new DateTimeMock());

      scoreStore.incrementScore(points);
      scoreStore.decrementScore(negativePoints);
      scoreStore.decrementScore(negativePoints);

      int unsuccessfulCount = scoreStore.retrieveUnsuccessfulPlacement();
      expect(unsuccessfulCount, 2);
    });

    test("should be able retrive number of successful interactions ", () {
      int points = 2;
      int negativePoints = 3;
      ScoreStore scoreStore = new ScoreStore(new DateTimeMock());

      scoreStore.incrementScore(points);
      scoreStore.incrementScore(points);
      scoreStore.decrementScore(negativePoints);

      int successfulCount = scoreStore.retrieveSuccessfulPlacement();
      expect(successfulCount, 2);
    });
  });
}
