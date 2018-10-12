import 'dart:ui';

import 'package:bumshakalaka/assert.dart';
import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/handler/drag_handler.dart';
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
    if (creationTimer >= logic.foodLatency) {
      creationTimer = 0.0;
      add(logic.getNextFood());
    }
    creationTimer += t;
  }

  void _addTargets() {
    if (!init) {
      if (logic.targets != null) {
        logic.targets.forEach((target) {
          add(target);
        });
        init = true;
      }
    }
  }

  Drag input(Offset event) {
    for (var component in components) {
      if ((component is Food)) {
        if (_isComponentTapped(event, component)) {
          component.isTouched = true;
          Drag drag = new DragHandler(_handleDragUpdate, _handleDragEnd);
          return drag;
        }
      }
    }
    return null;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    components.forEach((component) {
      if (component is Food) {
        if (component.isTouched) {
          component.y = details.globalPosition.dy;
          component.x = details.globalPosition.dx;
        }
      }
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    components.forEach((component) {
      if (component is Food) {
        component.isTouched = false;
      }
    });
  }

  bool _isComponentTapped(Offset event, Food component) =>
      event.dx >= component.x &&
      event.dx <= component.x + component.width &&
      event.dy >= component.y &&
      event.dy <= component.y + component.height;
}
