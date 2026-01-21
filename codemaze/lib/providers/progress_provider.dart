import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressProvider extends ChangeNotifier {
  int lessonsCompleted = 0;
  int quizzesPassed = 0;
  int puzzlesSolved = 0;

  ProgressProvider() {
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    lessonsCompleted = prefs.getInt('lessonsCompleted') ?? 0;
    quizzesPassed = prefs.getInt('quizzesPassed') ?? 0;
    puzzlesSolved = prefs.getInt('puzzlesSolved') ?? 0;
    notifyListeners();
  }

  Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lessonsCompleted', 0);
    await prefs.setInt('quizzesPassed', 0);
    await prefs.setInt('puzzlesSolved', 0);

    lessonsCompleted = 0;
    quizzesPassed = 0;
    puzzlesSolved = 0;

    notifyListeners();
  }
}
