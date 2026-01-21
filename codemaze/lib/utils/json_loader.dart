import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class JsonLoader {
  static Future<Map<String, dynamic>> loadJson(String path) async {
    final String jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }

  static Future<Map<String, dynamic>> loadLessons() => loadJson('assets/data/lessons.json');
  static Future<Map<String, dynamic>> loadQuizzes() => loadJson('assets/data/quizzes.json');
  static Future<Map<String, dynamic>> loadPuzzles() => loadJson('assets/data/puzzles.json');
}
