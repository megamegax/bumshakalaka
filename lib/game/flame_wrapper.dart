import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/gestures.dart';

class FlameWrapper {
  FlameAudio player;

  void disableAudioLog() {}

  void loadAudio(String audioPath) {
    //Flame.audio.load(audioPath);
  }

  void loadAllImages(List<String> imagePaths) {
    Flame.images.loadAll(imagePaths);
  }

  void playAudio(String audioFile) async {
    FlameAudio.playLongAudio(audioFile, volume: 1.0);
  }

  Future<Size> initialDimensions() async {}
}
