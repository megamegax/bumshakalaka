import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/game.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as widget;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../food/food_sprite_test.dart';
import '../test_assets_bundle.dart';
import '../util/domain_object.dart';

class MockLogic extends Mock implements Logic {}

void main() {
  Game game;
  MockLogic logic;
  MockFlameWrapper engine;
  setUp(() {
    logic = new MockLogic();
    engine = new MockFlameWrapper();
    game = new Game(logic, engine);
  });

  group("Constructor", () {
    test("logic should not be null", () {
      expect(() => new Game(null, engine), throwsArgumentError);
    });
    test("engine should not be null", () {
      expect(() => new Game(logic, null), throwsArgumentError);
    });
  });
  group("update", () {
    widget.testWidgets('targets should be added once',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.getUnsuccessfulPlacementCount()).thenReturn(1);
      when(logic.getSuccessfulPlacementCount()).thenReturn(1);
      when(logic.getSuccessfulPercentageOfPlacements()).thenReturn(1.0);
      when(logic.screenSize).thenReturn(new Size(200.0, 200.0));
      when(logic.getWindowName()).thenReturn("");
      when(logic.targets)
          .thenReturn([DomainObject.createTarget(x: 0.0, y: 0.0)]);
      when(logic.getNextFood(any)).thenReturn(DomainObject.createFood());
      when(logic.foodLatency()).thenReturn(1.0);
      game.gameStarted = true;
      widget.expect(game.init, false);
      game.update(0.0);
      widget.expect(game.components.length, 3);
      widget.expect(game.init, true);
      game.update(0.0);
      widget.expect(game.components.length, 3);
    });

    widget.testWidgets('foods should be added when logic says',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));
      when(logic.getWindowName()).thenReturn("");

      when(logic.getUnsuccessfulPlacementCount()).thenReturn(1);
      when(logic.getSuccessfulPlacementCount()).thenReturn(1);
      when(logic.getSuccessfulPercentageOfPlacements()).thenReturn(1.0);
      when(logic.screenSize).thenReturn(new Size(200.0, 200.0));
      when(logic.targets)
          .thenReturn([DomainObject.createTarget(x: 0.0, y: 0.0)]);
      when(logic.getNextFood(any)).thenReturn(DomainObject.createFood());

      game.gameStarted = true;
      when(logic.foodLatency()).thenReturn(1.0);
      game.update(1.0);
      widget.expect(game.components.length, 3);
      game.update(1.0);
      widget.expect(game.components.length, 4);
    });
  });

  group("input", () {
    logic = new MockLogic();
    engine = new MockFlameWrapper();
    game = new Game(logic, engine);
    
    widget.testWidgets('should detect currently tapped food',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));
      when(logic.getUnsuccessfulPlacementCount()).thenReturn(1);
      when(logic.getSuccessfulPlacementCount()).thenReturn(1);
      when(logic.getSuccessfulPercentageOfPlacements()).thenReturn(1.0);
      when(logic.screenSize).thenReturn(new Size(200.0, 200.0));
      when(logic.targets)
          .thenReturn([DomainObject.createTarget(x: 0.0, y: 0.0)]);
      when(logic.getNextFood((food) {
        return false;
      })).thenReturn(DomainObject.createFood(x: 0.0, y: 0.0));
      when(logic.foodLatency()).thenReturn(1.0);

      game.components.add(DomainObject.createFood(
          x: 0.0, y: 0.0, imageWidth: 64.0, imageHeight: 64.0));
      expect((game.components.first as Food).isTouched, false);
      game.input(new Offset(32.0, 32.0));
      expect((game.components.first as Food).isTouched, true);
    });

    widget.testWidgets('should detect when tapped not on food',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.getUnsuccessfulPlacementCount()).thenReturn(1);
      when(logic.getSuccessfulPlacementCount()).thenReturn(1);
      when(logic.getSuccessfulPercentageOfPlacements()).thenReturn(1.0);
      when(logic.targets)
          .thenReturn([DomainObject.createTarget(x: 0.0, y: 0.0)]);
      when(logic.getNextFood((food) {
        return false;
      })).thenReturn(DomainObject.createFood(x: 0.0, y: 0.0));
      when(logic.foodLatency()).thenReturn(1.0);

      game.components.add(DomainObject.createFood(x: 0.0, y: 0.0));
      expect((game.components.first as Food).isTouched, false);
      game.input(new Offset(99.0, 99.0));
      expect((game.components.first as Food).isTouched, false);
    });
  });
}
