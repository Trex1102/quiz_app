import 'package:flutter/material.dart';

class ScoreProvider with ChangeNotifier {
  int _score = 0;

  int get score => _score;

  void incrementScore() {
    _score++;
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }
}
