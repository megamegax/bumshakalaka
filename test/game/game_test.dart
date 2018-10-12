import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/game.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/target/dog.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockLogic extends Mock implements Logic {}

void main() {
  Game game;
  MockLogic logic;

  setUp(() {
    logic = new MockLogic();
    game = new Game(logic);
  });

  group("Constructor", () {
    test("logic should not be null", () {
      expect(() => new Game(null), throwsArgumentError);
    });
  });

  group("update2", () {
    test("foods should be added when logic says", () {
      when(logic.targets).thenReturn([new Dog(0.0, 0.0, "", 1)]);
      when(logic.getNextFood()).thenReturn(new Food(0.0, 0.0, "", 1));
      when(logic.foodMultiplier).thenReturn(1.0);
      expect(game.init, false);
      game.update(1);
      expect(game.components.length, 1);
      game.update(1);
      expect(game.init, true);
      expect(game.components.length, 2);
    });
  });
}
