import 'dart:ui';

import 'package:bumshakalaka/assert.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

class Game extends BaseGame {
  Game(Logic logic) {
    Assert.notNull(logic, "Logic must not be null!");
  }

  Drag input(Offset event) {
    return null;
  }
}
