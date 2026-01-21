// lib/models/lesson.dart
class Lesson {
  final String category;
  final String title;
  final String? shortDescription;
  final String detailedExplanation;
  final String exampleCode;
  final String expectedOutput;

  Lesson({
    required this.category,
    required this.title,
    this.shortDescription,
    required this.detailedExplanation,
    required this.exampleCode,
    required this.expectedOutput,
  });
}
