import 'dart:ui';

import 'package:bumshakalaka/assert.dart';
import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/handler/drag_handler.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/target/target.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Game extends BaseGame {
  Logic logic;

  double _creationTimer = 0.0;
  bool init = false;
  bool gameStarted = false;

  Game(Logic logic) {
    Assert.notNull(logic, "Logic must not be null!");
    this.logic = logic;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    String text = logic.totalScore.toString();
    TextPainter p = Flame.util.text(text,
        color: Colors.white, fontSize: 48.0, fontFamily: 'bitmapfont');
    p.paint(canvas, new Offset(10.0, 20.0));
  }

  @override
  void update(double t) {
    if (gameStarted) {
      _addTargets();
      _addFood(t);
    }
    super.update(t);
  }

  void _addFood(double t) {
    if (_creationTimer >= logic.foodLatency) {
      _creationTimer = 0.0;
      add(logic.getNextFood((Food food) {
        if (food.y > logic.screenSize.height) {
          logic.missedFood(food);
          return true;
        } else {
          if (food.toDestroy) {
            return true;
          }
          return false;
        }
      }));
    }
    _creationTimer += t;
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
          component.y = details.globalPosition.dy - 32;
          component.x = details.globalPosition.dx - 32;
        }
      }
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    components.forEach((component) {
      if (component is Food) {
        if (component.isTouched) {
          _isFoodDragedToTarget(component);
          component.isTouched = false;
        }
      }
    });
  }

  bool _isComponentTapped(Offset event, Food component) =>
      event.dx >= component.x &&
      event.dx <= component.x + component.width &&
      event.dy >= component.y &&
      event.dy <= component.y + component.height;

  bool _isComponentInTarget(Target target, Food component) =>
      target.x + target.width >= component.x &&
      target.x <= component.x + component.width &&
      target.y + target.height >= component.y &&
      target.y <= component.y + component.height;

  void start(Size screenSize) {
    this.size = screenSize;
    logic.start(screenSize);
    this.gameStarted = true;
  }

  void _isFoodDragedToTarget(Food component) {
    for (Target target in logic.targets) {
      if (_isComponentInTarget(target, component)) {
        logic.feedFoodTarget(target, component);
        component.toDestroy = true;
      }
    }
  }
}
