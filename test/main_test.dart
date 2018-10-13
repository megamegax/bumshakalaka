import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/flame_wrapper.dart';
import 'package:bumshakalaka/game/game.dart';
import 'package:bumshakalaka/main.dart';
import 'package:bumshakalaka/target/dog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as widget;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'food/food_sprite_test.dart';
import 'test_assets_bundle.dart';

class MockFlameWrapper extends Mock implements FlameWrapper {}

void main() {
  MockFlameWrapper engine;
  Game game;
  MockLogic logic;

  setUp(() {
    engine = new MockFlameWrapper();
    logic = new MockLogic();
    game = new Game(logic);
  });

  group("Main", () {
    widget.testWidgets('should disableAudioLogs',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.targets).thenReturn([new Dog(0.0, 0.0, "", 1)]);
      when(logic.getNextFood())
          .thenReturn(new Food(1.0, 1.0, "dog.png", 10.0, 64.0, 64.0, 1));
      when(logic.foodLatency).thenReturn(1.0);

      new Main(engine, game);
      widget.expect(verify(engine.disableAudioLog()).callCount, 1);
    });
    widget.testWidgets('should loadAudio', (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.targets).thenReturn([new Dog(0.0, 0.0, "", 1)]);
      when(logic.getNextFood())
          .thenReturn(new Food(1.0, 1.0, "dog.png", 10.0, 64.0, 64.0, 1));
      when(logic.foodLatency).thenReturn(1.0);

      new Main(engine, game);
      widget.expect(verify(engine.loadAudio(any)).callCount, 1);
    });
    widget.testWidgets('should loadAllImages',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.targets).thenReturn([new Dog(0.0, 0.0, "", 1)]);
      when(logic.getNextFood())
          .thenReturn(new Food(1.0, 1.0, "dog.png", 10.0, 64.0, 64.0, 1));
      when(logic.foodLatency).thenReturn(1.0);

      new Main(engine, game);
      widget.expect(verify(engine.loadAllImages(any)).callCount, 1);
    });
    widget.testWidgets('should addGestureRecognizer',
        (widget.WidgetTester tester) async {
      await tester.pumpWidget(new MaterialApp(
        home: new DefaultAssetBundle(
            bundle: new TestAssetBundle(), child: game.widget),
      ));

      when(logic.targets).thenReturn([new Dog(0.0, 0.0, "", 1)]);
      when(logic.getNextFood())
          .thenReturn(new Food(1.0, 1.0, "dog.png", 10.0, 64.0, 64.0, 1));
      when(logic.foodLatency).thenReturn(1.0);

      new Main(engine, game);
      widget.expect(verify(engine.addGestureRecognizer(any)).callCount, 1);
    });
  });
}
