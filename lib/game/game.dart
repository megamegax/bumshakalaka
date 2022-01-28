import 'package:bumshakalaka/food/food.dart';
import 'package:bumshakalaka/game/component/window.dart';
import 'package:bumshakalaka/game/flame_wrapper.dart';
import 'package:bumshakalaka/game/handler/drag_handler.dart';
import 'package:bumshakalaka/logic/game_logic.dart';
import 'package:bumshakalaka/logic/logic.dart';
import 'package:bumshakalaka/target/target.dart';
import 'package:bumshakalaka/util/assert.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class MyGame extends FlameGame with WidgetsBindingObserver, PanDetector {
  Logic logic;
  double _creationTimer = 0.0;
  bool init = false;
  bool gameStarted = false;
  Window _window;
  FlameWrapper _engine;
  bool _hasToUpdateWindow = true;
  bool _gameEnded = false;
  Size screenSize;

  MyGame(GameLogic logic, FlameWrapper engine) {
    Assert.notNull(logic, "Logic must not be null!");
    Assert.notNull(engine, "Engine must not be null!");
    this.logic = logic;
    this._engine = engine;
    pauseEngine();
    engine.playAudio("megaman.mp3");
  }

  @override
  Future<void> onLoad() {
    super.onLoad();
    screenSize = Size(size[0], size[1]);
    start();
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
        pauseEngine();
        break;
      case AppLifecycleState.resumed:
        resumeEngine();
        break;
      default:
    }
  }

  void _addFood(double t) async {
    if (_creationTimer >= logic.foodLatency()) {
      _creationTimer = 0.0;
      Function destroyAction = (Food food) {
        if (food.y > logic.screenSize.y) {
          logic.missedFood(food);
          return true;
        } else {
          if (food.toDestroy) {
            return true;
          }
          return false;
        }
      };

      add(await logic.getNextFood(destroyAction, images));
    }
    _creationTimer += t;
  }

  void _addBackground() async {
    if (!init) {
      add(new SpriteComponent(
          size: Vector2(logic.screenSize.x, logic.screenSize.y),
          sprite: await Sprite.load("walls.png")));
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

  @override
  void onPanDown(DragDownInfo info) {
    super.onPanDown(info);
    input(info.raw.localPosition);
  }

  Drag input(Offset event) {
    for (var component in children) {
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
    children.forEach((component) {
      if (component is Food) {
        if (component.isTouched) {
          component.y = details.globalPosition.dy - 32;
          component.x = details.globalPosition.dx - 32;
        }
      }
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    children.forEach((component) {
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

  void start() {
    resumeEngine();
    logic.start(Vector2(screenSize.width, screenSize.height), images);
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

  void _updateWindow() async {
    if (_hasToUpdateWindow) {
      final windowSprite = await Sprite.load(logic.getWindowName());
      _window = new Window(
          logic.screenSize.x / 2, logic.screenSize.y / 3, windowSprite);
      _window.x = logic.screenSize.x / 2.0 - logic.screenSize.x * 0.2;
      _window.y = logic.screenSize.y / 2.0 - logic.screenSize.x * 0.3;
      add(_window);
      _hasToUpdateWindow = false;
    }
    if (_window.imagePath != logic.getWindowName()) {
      _window.toDestroy = true;
      _hasToUpdateWindow = true;
    }
  }

  void _endGame() {
    for (Component component in children) {
      if (component is Sprite) {
        component.onRemove();

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

  void _printCurrentScore(Canvas canvas, [double fontSize = 48.0]) {
    var text = logic.getTotalScore().toString();
    var textPainter = _createTextPainter(text);
    textPainter.layout();
    textPainter.text = TextSpan(
        text: text ?? "",
        style: TextStyle(
            color: Colors.white, fontFamily: 'bitmapfont', fontSize: fontSize));

    textPainter.paint(canvas, new Offset(10.0, 20.0));
  }

  TextPainter _createTextPainter(String text, [double fontSize = 48.0]) {
    return TextPainter(textAlign: TextAlign.center);
  }

  void _printText(Canvas canvas, String text, Offset offset,
      [double fontSize = 48.0]) {
    var textPainter = _createTextPainter(text, fontSize);
    textPainter.layout();
    textPainter.text = TextSpan(
        text: text ?? "",
        style: TextStyle(
            color: Colors.white, fontFamily: 'bitmapfont', fontSize: fontSize));
    textPainter.paint(canvas, offset);
  }
}
