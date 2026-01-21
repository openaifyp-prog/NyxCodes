import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static const _lessonsKey = 'completedLessons';
  static const _quizzesKey = 'completedQuizzes';
  static const _puzzlesKey = 'completedPuzzles';

  /// Returns the set of completed lesson IDs.
  static Future<Set<String>> getCompletedLessons() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_lessonsKey)?.toSet() ?? {};
  }

  /// Marks a lesson as completed.
  static Future<void> completeLesson(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();
    final set = (prefs.getStringList(_lessonsKey) ?? []).toSet();
    set.add(lessonId);
    await prefs.setStringList(_lessonsKey, set.toList());
  }

  /// Returns the set of completed quiz IDs.
  static Future<Set<String>> getCompletedQuizzes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_quizzesKey)?.toSet() ?? {};
  }

  /// Marks a quiz as completed.
  static Future<void> completeQuiz(String quizId) async {
    final prefs = await SharedPreferences.getInstance();
    final set = (prefs.getStringList(_quizzesKey) ?? []).toSet();
    set.add(quizId);
    await prefs.setStringList(_quizzesKey, set.toList());
  }

  /// Returns the set of completed puzzle IDs.
  static Future<Set<String>> getCompletedPuzzles() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_puzzlesKey)?.toSet() ?? {};
  }

  /// Marks a puzzle as completed.
  static Future<void> completePuzzle(String puzzleId) async {
    final prefs = await SharedPreferences.getInstance();
    final set = (prefs.getStringList(_puzzlesKey) ?? []).toSet();
    set.add(puzzleId);
    await prefs.setStringList(_puzzlesKey, set.toList());
  }
}
