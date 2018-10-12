import 'dart:ui';

import 'package:bumshakalaka/assert.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

class Game extends BaseGame {
  Logic logic;

  double creationTimer = 0.0;
  bool init = false;

  Game(Logic logic) {
    Assert.notNull(logic, "Logic must not be null!");
    this.logic = logic;
  }

  @override
  void update(double t) {
    _addTargets();
    _addFood(t);
    super.update(t);
  }

  void _addFood(double t) {
    if (creationTimer >= logic.foodMultiplier) {
      creationTimer = 0.0;
      add(logic.getNextFood());
    }
    creationTimer += t;
  }

  void _addTargets() {
    if (!init) {
      logic.targets.forEach((target) {
        add(target);
      });
      init = true;
    }
  }

  Drag input(Offset event) {
    return null;
  }
}
