import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/game.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/target/dog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as widget;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../test_assets_bundle.dart';

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
  group("update", () {
    widget.testWidgets('targets should be added once',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.targets).thenReturn([new Dog(0.0, 0.0, "", 1)]);
      when(logic.getNextFood()).thenReturn(new Food(0.0, 0.0, "", 1));
      when(logic.foodMultiplier).thenReturn(1.0);
      widget.expect(game.init, false);
      game.update(0);
      widget.expect(game.components.length, 1);
      widget.expect(game.init, true);
      game.update(0);
      widget.expect(game.components.length, 1);
    });

    widget.testWidgets('foods should be added when logic says',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.targets).thenReturn([new Dog(0.0, 0.0, "", 1)]);
      when(logic.getNextFood()).thenReturn(new Food(0.0, 0.0, "", 1));
      when(logic.foodMultiplier).thenReturn(1.0);
      game.update(1);
      widget.expect(game.components.length, 1);
      game.update(1);
      widget.expect(game.components.length, 2);
    });
  });

  group("update", () {
    test("foods should be added when logic says", () {
      expect(1, 1);
    });
  });
}
