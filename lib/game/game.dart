import 'dart:ui';

import 'package:bumshakalaka/Sprite.dart';
import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/component/window.dart';
import 'package:bumshakalaka/game/flame_wrapper.dart';
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

class Game extends BaseGame with WidgetsBindingObserver {
  Logic logic;
  double _creationTimer = 0.0;
  bool init = false;
  bool gameStarted = false;
  Window _window;
  FlameWrapper _engine;
  bool _hasToUpdateWindow = true;
  bool _gameEnded = false;

  Game(Logic logic, FlameWrapper engine) {
    Assert.notNull(logic, "Logic must not be null!");
    Assert.notNull(engine, "Engine must not be null!");
    this.logic = logic;
    this._engine = engine;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (!_gameEnded) {
      _printCurrentScore(canvas);
    }
    if (_gameEnded) {
      _printFinalScore(canvas);
      _printGameOver(canvas);
      _printCongratPlayer(canvas);
      _printHowMuchPlayerSaved(canvas);
      logic.gameOver();
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _engine.player.pause();
        break;
      case AppLifecycleState.resumed:
        _engine.player.resume();
        break;
      default:
    }
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
    WidgetsBinding.instance.addObserver(this);
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
    if (_hasToUpdateWindow) {
      _window = new Window(logic.screenSize.width / 2,
          logic.screenSize.height / 3, logic.getWindowName());
      _window.x = logic.screenSize.width / 2.0 - _window.width / 2 + 45;
      _window.y = logic.screenSize.height / 2.0 - _window.height / 2 - 60;
      add(_window);
      _hasToUpdateWindow = false;
    }
    if (_window.imagePath != logic.getWindowName()) {
      _window.toDestroy = true;
      _hasToUpdateWindow = true;
    }
  }

  void _endGame() {
    for (Component component in components) {
      if (component is Sprite) {
        component.toDestroy = true;
        // TODO ouf of for cycle?
        _gameEnded = true;
      }
    }
  }

  void _printHowMuchPlayerSaved(Canvas canvas) {
    var howMuchPlayerSaved =
        "Megmentettel \n${logic.getSuccessfulPlacementCount()}kg elelmiszert!";
    _printText(canvas, howMuchPlayerSaved, new Offset(90.0, 580.0), 40.0);
  }

  void _printCongratPlayer(Canvas canvas) {
    var successfulPercentageOfPlacements =
        logic.getSuccessfulPercentageOfPlacements().toStringAsFixed(2);
    var congratPlayerText =
        "Gratulalunk! \nAz esetek\n$successfulPercentageOfPlacements%-ban\njol dontottel!";
    _printText(canvas, congratPlayerText, new Offset(90.0, 390.0), 40.0);
  }

  void _printGameOver(Canvas canvas) {
    var gameOverText = "Game Over!";
    _printText(canvas, gameOverText, new Offset(80.0, 100.0), 58.0);
  }

  void _printFinalScore(Canvas canvas) {
    var finalScoreText = "Score: ${logic.getTotalScore().toString()}";
    _printText(canvas, finalScoreText, new Offset(10.0, 20.0));
  }

  void _printCurrentScore(Canvas canvas) {
    var text = logic.getTotalScore().toString();
    var textPainter = _createTextPainter(text);
    textPainter.paint(canvas, new Offset(10.0, 20.0));
  }

  TextPainter _createTextPainter(String text, [double fontSize = 48.0]) {
    return Flame.util.text(text,
        fontSize: fontSize,
        color: Colors.white,
        fontFamily: 'bitmapfont',
        textAlign: TextAlign.center);
  }

  void _printText(Canvas canvas, String text, Offset offset,
      [double fontSize = 48.0]) {
    var textPainter = _createTextPainter(text, fontSize);
    textPainter.paint(canvas, offset);
  }
}
