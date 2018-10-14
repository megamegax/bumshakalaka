import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:bumshakalaka/config/config.dart';
import 'package:bumshakalaka/food/food_provider.dart';
import 'package:bumshakalaka/game/flame_wrapper.dart';
import 'package:bumshakalaka/game/game.dart';
import 'package:bumshakalaka/history/score_store.dart';
import 'package:bumshakalaka/logic/game_logic.dart';
import 'package:bumshakalaka/logic/speed_calculator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

main() async {
  FirebaseAnalytics analytics = new FirebaseAnalytics();
  analytics.logAppOpen();
  await Flame.util.initialDimensions();
  var config = await _loadConfig();
  var gameLogic = _createGameLogic(config,analytics);
  var flameWrapper = new FlameWrapper();
  var game = new Game(gameLogic);
  new Main(flameWrapper, game);
}

GameLogic _createGameLogic(Config config, FirebaseAnalytics analytics) {
  var random = new Random();
  var foodProvider = new FoodProvider(config.foodConfigs, random);
  var speedCalculator = new SpeedCalculator(40.0, 5.0);
  var scoreStore = new ScoreStore();
  var gameLogic = new GameLogic(
      config, foodProvider, random, speedCalculator, scoreStore, analytics);
  return gameLogic;
}

Future<Config> _loadConfig() async {
  var stringConfig = await rootBundle.loadString("assets/config.json");
  var config = Config.fromJson(jsonDecode(stringConfig));
  return config;
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
      'walls.png',
      'window.png',
      'window_dry_tree.png',
      'window_moon.png'
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
