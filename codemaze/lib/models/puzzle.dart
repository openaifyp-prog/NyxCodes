class Puzzle {
  final int id;
  final String category;
  final String title;
  final String description;
  final String hint;
  final String solution;
  final List<String> correctAnswers;
  final String difficulty;

  Puzzle({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.hint,
    required this.solution,
    required this.correctAnswers,
    required this.difficulty,
  });
}
