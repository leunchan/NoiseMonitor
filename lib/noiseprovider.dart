import 'package:flutter/material.dart';

class NoiseLevelProvider extends ChangeNotifier {
  double _noiseLevel = 0.0;

  double get noiseLevel => _noiseLevel;

  void updateNoiseLevel(double newNoiseLevel) {
    _noiseLevel = newNoiseLevel;
    notifyListeners();
  }
}
