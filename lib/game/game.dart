import 'dart:ui';

import 'package:bumshakalaka/Sprite.dart';
import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/component/window.dart';
import 'package:bumshakalaka/game/handler/drag_handler.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/target/target.dart';
import 'package:bumshakalaka/util/assert.dart';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vibrate/vibrate.dart';

class Game extends BaseGame {
  Logic logic;

  double _creationTimer = 0.0;
  bool init = false;
  bool gameStarted = false;
  Window window;
  bool hasToUpdateWindow = true;
  bool gameEnded = false;

  Game(Logic logic) {
    Assert.notNull(logic, "Logic must not be null!");
    this.logic = logic;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (!gameEnded) {
      String text = logic.getTotalScore().toString();
      TextPainter p = Flame.util.text(text,
          color: Colors.white, fontSize: 48.0, fontFamily: 'bitmapfont');
      p.paint(canvas, new Offset(10.0, 20.0));
    }
    if (gameEnded) {
      String text = "Score: ${logic.getTotalScore().toString()}";
      TextPainter p = Flame.util.text(text,
          color: Colors.white, fontSize: 48.0, fontFamily: 'bitmapfont');
      p.paint(canvas, new Offset(10.0, 20.0));

      TextPainter gameOverPainter = Flame.util.text("GameOver",
          color: Colors.white, fontSize: 48.0, fontFamily: 'bitmapfont');
      gameOverPainter.paint(canvas, new Offset(120.0, 100.0));
      var successfulPercentageOfPlacements = logic
          .getSuccessfulPercentageOfPlacements()
          .toString()
          .padLeft(2, '0');
      TextPainter earthLivedForXMinutes = Flame.util.text(
          "Gratulalunk! \n$successfulPercentageOfPlacements%-ban jol dontottel!",
          color: Colors.white,
          fontSize: 40.0,
          textAlign: TextAlign.center,
          fontFamily: 'bitmapfont');
      earthLivedForXMinutes.paint(canvas, new Offset(30.0, 420.0));
      TextPainter savedFood = Flame.util.text(
          "Megmentettel \n${logic.getSuccessfulPlacementCount()}kg elelmiszert!",
          color: Colors.white,
          fontSize: 40.0,
          textAlign: TextAlign.center,
          fontFamily: 'bitmapfont');
      savedFood.paint(canvas, new Offset(80.0, 550.0));
    }
  }

  @override
  void update(double t) {
    if (gameStarted) {
      _addBackground();
      _updateWindow();
      _addTargets();
      _addFood(t);
      if (logic.getUnsuccessfulPlacementCount() >= 50) {
        _endGame();
      }
    }
    super.update(t);
  }

  void _addFood(double t) {
    if (_creationTimer >= logic.foodLatency()) {
      _creationTimer = 0.0;
      Function destroyAction = (Food food) {
        if (food.y > logic.screenSize.height) {
          logic.missedFood(food);
          return true;
        } else {
          if (food.toDestroy) {
            return true;
          }
          return false;
        }
      };
      add(logic.getNextFood(destroyAction));
    }
    _creationTimer += t;
  }

  void _addBackground() {
    if (!init) {
      add(new SpriteComponent.rectangle(
          logic.screenSize.width, logic.screenSize.height, "walls.png"));
    }
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
        var result = logic.feedFoodTarget(target, component);
        component.toDestroy = true;
        if (result < 0) {
          Vibrate.vibrate();
        }
      }
    }
  }

  void _updateWindow() {
    if (hasToUpdateWindow) {
      window = new Window(logic.screenSize.width / 2,
          logic.screenSize.height / 3, logic.getWindowName());
      window.x = logic.screenSize.width / 2.0 - window.width / 2 + 45;
      window.y = logic.screenSize.height / 2.0 - window.height / 2 - 60;
      add(window);
      hasToUpdateWindow = false;
    }
    if (window.imagePath != logic.getWindowName()) {
      window.toDestroy = true;
      hasToUpdateWindow = true;
    }
  }

  void _endGame() {
    for (Component component in components) {
      if (component is Sprite) {
        component.toDestroy = true;
        gameEnded = true;
      }
    }
  }
}
