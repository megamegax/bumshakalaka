import 'dart:async';
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
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

main() async {
  startApp();
}

void startApp() async {
  await Flame.util.initialDimensions();
  var config = await _loadConfig();
  var gameLogic = _createGameLogic(config);
  var engine = new FlameWrapper();
  var game = new Game(gameLogic, engine);
  new Main(engine, game);
}

GameLogic _createGameLogic(Config config) {
  var random = new Random();
  var foodProvider = new FoodProvider(config.foodConfigs, random);
  var speedCalculator = new SpeedCalculator(40.0, 5.0);
  var scoreStore = new ScoreStore();
  var gameLogic =
      new GameLogic(config, foodProvider, random, speedCalculator, scoreStore);
  return gameLogic;
}

Future<Config> _loadConfig() async {
  var stringConfig = """{
  "foods": [
    {
      "image_path": "green_apple.png",
      "target": "fridge",
      "frame_count": 1,
      "image_width": 74,
      "image_height": 74
    },
    {
      "image_path": "red_apple.png",
      "target": "fridge",
      "frame_count": 1,
      "image_width": 74,
      "image_height": 74
    },
    {
      "image_path": "cheese.png",
      "target": "fridge",
      "frame_count": 1,
      "image_width": 74,
      "image_height": 74
    },
    {
      "image_path": "fish.png",
      "target": "fridge",
      "frame_count": 1,
      "image_width": 74,
      "image_height": 74
    },
    {
      "image_path": "lemon.png",
      "target": "fridge",
      "frame_count": 1,
      "image_width": 74,
      "image_height": 74
    },
    {
      "image_path": "whole_grilled_chicken.png",
      "target": "fridge",
      "frame_count": 1,
      "image_width": 74,
      "image_height": 74
    },
    {
      "image_path": "apple_core.png",
      "target": "compost",
      "frame_count": 1,
      "image_width": 64,
      "image_height": 64
    },
    {
      "image_path": "watermelon_peel_big_64_33.png",
      "target": "compost",
      "frame_count": 1,
      "image_width": 64,
      "image_height": 640
    },
    {
      "image_path": "banana_peel.png",
      "target": "compost",
      "frame_count": 1,
      "image_width": 64,
      "image_height": 64
    },
    {
      "image_path": "bone.png",
      "target": "dog",
      "frame_count": 1,
      "image_width": 64,
      "image_height": 64
    },
    {
      "image_path": "chicken_thigh_half.png",
      "target": "dog",
      "frame_count": 1,
      "image_width": 64,
      "image_height": 64
    }
  ],
  "targets": [
    {
      "name": "dog",
      "image_path": "dog_big.png",
      "frame_count": 8,
      "image_width": 155,
      "image_height": 182
    },
    {
      "name": "fridge",
      "image_path": "fridge_big_trimmed.png",
      "frame_count": 11,
      "image_width": 150,
      "image_height": 187
    },
    {
      "name": "compost",
      "image_path": "compost_big_trimmed.png",
      "frame_count": 8,
      "image_width": 100,
      "image_height": 123
    }
  ]
}""";
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
      'walls.png',
      'dumpster.png',
      'fish.png',
      'fridge.png',
      'lemon.png',
      'green_apple.png',
      'whole_grilled_chicken.png',
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
