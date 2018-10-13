import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:bumshakalaka/config/config.dart';
import 'package:bumshakalaka/food/food_provider.dart';
import 'package:bumshakalaka/game/flame_wrapper.dart';
import 'package:bumshakalaka/game/game.dart';
import 'package:bumshakalaka/logic/game_logic.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

main() async {
  FlameWrapper engine = new FlameWrapper();
  String stringConfig = await rootBundle.loadString("assets/config.json");
  Config config = Config.fromJson(jsonDecode(stringConfig));
  Random random = new Random();
  FoodProvider foodProvider = new FoodProvider(config.foodConfigs, random);
  GameLogic gameLogic = new GameLogic(config, 1.0, foodProvider);
  Game game = new Game(gameLogic);
  new Main(engine, game);
}

class Main {
  Game game;

  Main(FlameWrapper engine, Game game) {
    engine.disableAudioLog();
    engine.loadAudio("megaman.mp3");
    engine.loadAllImages([
      'red_apple.png',
      'cheese.png',
      'compost.png',
      'dog.png',
      'dumpster.png',
      'fish.png',
      'fridge.png',
      'lemon.png',
      'green_apple.png',
      'whole_grilled_chicken.png',
    ]);
    this.game = game;
    runApp(game.widget);
    final size = engine.initialDimensions();
    if (size != null) {
      size.then((size) {
        game.start(size);
      });
    }
    engine.addGestureRecognizer(new ImmediateMultiDragGestureRecognizer()
      ..onStart = (Offset event) => game.input(event));

    engine.playAudio("megaman.mp3");
  }
}
