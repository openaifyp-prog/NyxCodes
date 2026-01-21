import 'package:flutter/material.dart';
import '../utils/json_loader.dart';

class QuizProvider extends ChangeNotifier {
  Map<String, dynamic> _quizzes = {};

  Map<String, dynamic> get quizzes => _quizzes;

  bool get isLoaded => _quizzes.isNotEmpty;

  Future<void> loadQuizzes() async {
    _quizzes = await JsonLoader.loadQuizzes();
    notifyListeners();
  }

  List<Map<String, dynamic>> getQuizQuestions(String category, String lesson) {
    if (_quizzes.containsKey(category) && _quizzes[category].containsKey(lesson)) {
      return List<Map<String, dynamic>>.from(_quizzes[category][lesson]);
    }
    return [];
  }
}
