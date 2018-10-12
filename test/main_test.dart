import 'package:bumshakalaka/game/flame_wrapper.dart';
import 'package:bumshakalaka/main.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockFlameWrapper extends Mock implements FlameWrapper {}

void main() {
  MockFlameWrapper engine;
  setUp(() {
    engine = new MockFlameWrapper();
  });

  group("Main", () {
    test("should disableAudioLogs", () {
      new Main(engine);
      expect(verify(engine.disableAudioLog()).callCount, 1);
    });
    test("should loadAudio", () {
      new Main(engine);
      expect(verify(engine.loadAudio(any)).callCount, 1);
    });
    test("should loadAllImages", () {
      new Main(engine);
      expect(verify(engine.loadAllImages(any)).callCount, 1);
    });
    test("should addGestureRecognizer", () {
      new Main(engine);
      expect(verify(engine.addGestureRecognizer(any)).callCount, 1);
    });
  });
}
