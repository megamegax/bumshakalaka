import 'package:bumshakalaka/game/game.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockLogic extends Mock implements Logic {}

void main() {
  Game game;
  setUp(() {
    MockLogic logic = new MockLogic();
    game = new Game(logic);
  });

  group("Constructor", () {
    test("logic must not be null", () {
      expect(() => new Game(null), throwsArgumentError);
    });
  });
}
