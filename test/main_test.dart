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
  });
}
