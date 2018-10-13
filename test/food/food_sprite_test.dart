import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/game.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/target/dog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../test_assets_bundle.dart';

class MockLogic extends Mock implements Logic {}

void main() async {
  Game game;
  MockLogic logic;
  setUp(() {
    logic = new MockLogic();
    game = new Game(logic);
  });

  testWidgets('FoodSprite Constructor X must not be null!',
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new DefaultAssetBundle(
          bundle: new TestAssetBundle(), child: game.widget),
    ));

    when(logic.targets).thenReturn([new Dog(0.0, 0.0)]);
    when(logic.getNextFood(() {
      return false;
    })).thenReturn(new Food(0.0, 0.0, "", 1.0, 1.0, 1.0, 1, () {
      return false;
    }));
    when(logic.foodLatency).thenReturn(1.0);

    expect(
        () => new Food(null, 1.0, 'kutya.png', 1.0, 1.0, 1.0, 10, () {
              return false;
            }),
        throwsArgumentError);
  });

  testWidgets('FoodSprite Constructor Y must not be null!',
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new DefaultAssetBundle(
          bundle: new TestAssetBundle(), child: game.widget),
    ));

    when(logic.targets).thenReturn([new Dog(0.0, 0.0)]);
    when(logic.getNextFood(() {
      return false;
    })).thenReturn(new Food(0.0, 0.0, "", 1.0, 1.0, 1.0, 1, () {
      return false;
    }));
    when(logic.foodLatency).thenReturn(1.0);

    expect(
        () => new Food(1.0, null, 'kutya.png', 1.0, 1.0, 1.0, 10, () {
              return false;
            }),
        throwsArgumentError);
  });

  testWidgets('FoodSprite Constructor frameCount must not be null!',
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new DefaultAssetBundle(
          bundle: new TestAssetBundle(), child: game.widget),
    ));

    when(logic.targets).thenReturn([new Dog(0.0, 0.0)]);
    when(logic.getNextFood(() {
      return false;
    })).thenReturn(new Food(0.0, 0.0, "", 1.0, 64.0, 64.0, 1, () {
      return false;
    }));
    when(logic.foodLatency).thenReturn(1.0);

    expect(
        () => new Food(1.0, null, "dog.png", 1.0, 1.0, 1.0, null, () {
              return false;
            }),
        throwsArgumentError);
  });

  testWidgets('FoodSprite update should change y coordinate',
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new DefaultAssetBundle(
          bundle: new TestAssetBundle(), child: game.widget),
    ));

    when(logic.targets).thenReturn([new Dog(0.0, 0.0)]);
    when(logic.getNextFood(() {
      return false;
    })).thenReturn(new Food(0.0, 0.0, "", 1.0, 64.0, 64.0, 1, () {
      return false;
    }));
    when(logic.foodLatency).thenReturn(1.0);

    Food food = new Food(1.0, 1.0, "dog.png", 10.0, 64.0, 64.0, 1, () {
      return false;
    });
    expect(food.x, 1.0);
    expect(food.y, 1.0);
    food.update(0.1);
    expect(food.x, 1.0);
    expect(food.y, 2.0);
  });
}
