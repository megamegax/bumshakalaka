import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:bumshakalaka/config/config.dart';
import 'package:bumshakalaka/food/food_provider.dart';
import 'package:bumshakalaka/game/flame_wrapper.dart';
import 'package:bumshakalaka/game/game.dart' show GameWidget, MyGame;
import 'package:bumshakalaka/history/score_store.dart';
import 'package:bumshakalaka/logic/game_logic.dart';
import 'package:bumshakalaka/logic/speed_calculator.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  startApp();
}

void startApp() async {
  // await Flame.device.fullScreen();
  var config = await _loadConfig();
  var gameLogic = _createGameLogic(config);
  var engine = new FlameWrapper();
  var game = new MyGame(gameLogic, engine);
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
      "image_height": 64
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
      "name": "fridge",
      "image_path": "fridge_big_trimmed.png",
      "frame_count": 11,
      "image_width": 180,
      "image_height": 207
    },
        {
      "name": "dog",
      "image_path": "dog_big.png",
      "frame_count": 8,
      "image_width": 185,
      "image_height": 202
    },
    {
      "name": "compost",
      "image_path": "compost_big_trimmed.png",
      "frame_count": 8,
      "image_width": 130,
      "image_height": 133
    }
  ]
}""";
  var config = Config.fromJson(jsonDecode(stringConfig));
  return config;
}

class Main {
  MyGame game;

  Main(FlameWrapper engine, MyGame game) {
    engine.disableAudioLog();

    ///  engine.loadAudio("megaman.mp3");

    Flame.images.loadAllImages();

    this.game = game;
    runApp(GameWidget(game: game));

    // game.start();
  }
}
