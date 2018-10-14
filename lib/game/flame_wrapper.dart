import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';

class FlameWrapper {
  AudioPlayer player;

  void disableAudioLog() {
    Flame.audio.disableLog();
  }

  void loadAudio(String audioPath) {
    Flame.audio.load(audioPath);
  }

  void loadAllImages(List<String> imagePaths) {
    Flame.images.loadAll(imagePaths);
  }

  void addGestureRecognizer(GestureRecognizer gestureRecognizer) {
    Flame.util.addGestureRecognizer(gestureRecognizer);
  }

  void playAudio(String audioFile) async {
    player = await Flame.audio.play(audioFile, volume: 1.0);
    player.setReleaseMode(ReleaseMode.LOOP);
  }

  Future<Size> initialDimensions() async {
    return Flame.util.initialDimensions();
  }
}
