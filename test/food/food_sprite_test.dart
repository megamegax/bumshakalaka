import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/game.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../test_assets_bundle.dart';

class MockLogic extends Mock implements Logic {}

void main() async {
  testWidgets('FoodSprite Constructor X must not be null!',
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new DefaultAssetBundle(
          bundle: new TestAssetBundle(),
          child: new Game(new MockLogic()).widget),
    ));

    expect(() => new Food(null, 1.0, 'kutya.png', 10), throwsArgumentError);
  });

  testWidgets('FoodSprite Constructor Y must not be null!',
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new DefaultAssetBundle(
          bundle: new TestAssetBundle(),
          child: new Game(new MockLogic()).widget),
    ));

    expect(() => new Food(1.0, null, 'kutya.png', 10), throwsArgumentError);
  });

  testWidgets('FoodSprite Constructor animationCount must not be null!',
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new DefaultAssetBundle(
          bundle: new TestAssetBundle(),
          child: new Game(new MockLogic()).widget),
    ));

    expect(() => new Food(1.0, 1.0, 'kutya.png', null), throwsArgumentError);
  });
}
