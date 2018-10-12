import 'dart:ui';

import 'package:bumshakalaka/game/flame_wrapper.dart';
import 'package:bumshakalaka/game/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

main() async {
  FlameWrapper engine = new FlameWrapper();

  new Main(engine);
}

class Main {
  Game game;

  Main(FlameWrapper engine) {
    engine.disableAudioLog();
    engine.loadAudio("megaman.mp3");
    engine.loadAllImages([
      'apple.png',
      'cheese.png',
      'compost.png',
      'dog.png',
      'dumpster.png',
      'fish.png',
      'fridge.png',
      'lemon.png',
      'whole_green_apple.png',
      'whole_grilled_chicken.png',
    ]);
    game = new Game();
    engine.addGestureRecognizer(new ImmediateMultiDragGestureRecognizer()
      ..onStart = (Offset event) => game.input(event));
    runApp(game.widget);
  }
}
