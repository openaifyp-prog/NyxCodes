import 'package:flutter/material.dart';
import '../utils/json_loader.dart';

class PuzzleProvider extends ChangeNotifier {
  Map<String, dynamic> _puzzles = {};

  Map<String, dynamic> get puzzles => _puzzles;

  bool get isLoaded => _puzzles.isNotEmpty;

  Future<void> loadPuzzles() async {
    _puzzles = await JsonLoader.loadPuzzles();
    notifyListeners();
  }

  List<Map<String, dynamic>> getPuzzleQuestions(String category, String lesson) {
    if (_puzzles.containsKey(category) && _puzzles[category].containsKey(lesson)) {
      return List<Map<String, dynamic>>.from(_puzzles[category][lesson]);
    }
    return [];
  }
}
