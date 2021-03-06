import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/flame_wrapper.dart';
import 'package:bumshakalaka/game/game.dart';
import 'package:bumshakalaka/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as widget;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'food/food_sprite_test.dart';
import 'test_assets_bundle.dart';
import 'util/domain_object.dart';

class MockFlameWrapper extends Mock implements FlameWrapper {}

void main() {
  MockFlameWrapper engine;
  Game game;
  MockLogic logic;

  setUp(() {
    engine = new MockFlameWrapper();
    logic = new MockLogic();
    game = new Game(logic, engine);
  });

  group("Main", () {
    widget.testWidgets('should disableAudioLogs',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.targets)
          .thenReturn([DomainObject.createTarget(x: 0.0, y: 0.0)]);
      when(logic.getNextFood((food) {
        return false;
      })).thenReturn(new Food(1.0, 1.0, "dog.png", 10.0, 64.0, 64.0, 1, (food) {
        return false;
      }));
      when(logic.foodLatency()).thenReturn(1.0);

      new Main(engine, game);
      widget.expect(verify(engine.disableAudioLog()).callCount, 1);
    });
    widget.testWidgets('should loadAudio', (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.targets)
          .thenReturn([DomainObject.createTarget(x: 0.0, y: 0.0)]);
      when(logic.getNextFood((food) {
        return false;
      })).thenReturn(new Food(1.0, 1.0, "dog.png", 10.0, 64.0, 64.0, 1, (food) {
        return false;
      }));
      when(logic.foodLatency()).thenReturn(1.0);

      new Main(engine, game);
      widget.expect(verify(engine.loadAudio(any)).callCount, 1);
    });
    widget.testWidgets('should loadAllImages',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.targets)
          .thenReturn([DomainObject.createTarget(x: 0.0, y: 0.0)]);
      when(logic.getNextFood((food) {
        return false;
      })).thenReturn(new Food(1.0, 1.0, "dog.png", 10.0, 64.0, 64.0, 1, (food) {
        return false;
      }));
      when(logic.foodLatency()).thenReturn(1.0);

      new Main(engine, game);
      widget.expect(verify(engine.loadAllImages(any)).callCount, 1);
    });
    widget.testWidgets('should addGestureRecognizer',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.targets)
          .thenReturn([DomainObject.createTarget(x: 0.0, y: 0.0)]);
      when(logic.getNextFood((food) {
        return false;
      })).thenReturn(new Food(1.0, 1.0, "dog.png", 10.0, 64.0, 64.0, 1, (food) {
        return false;
      }));
      when(logic.foodLatency()).thenReturn(1.0);

      new Main(engine, game);
      widget.expect(verify(engine.addGestureRecognizer(any)).callCount, 1);
    });
  });
}
