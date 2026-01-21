import 'package:flutter/material.dart';
import '../models/puzzle.dart';

class PuzzleSolvePage extends StatefulWidget {
  final Puzzle puzzle;

  const PuzzleSolvePage({required this.puzzle, Key? key}) : super(key: key);

  @override
  State<PuzzleSolvePage> createState() => _PuzzleSolvePageState();
}

class _PuzzleSolvePageState extends State<PuzzleSolvePage> {
  final TextEditingController _answerController = TextEditingController();
  String? _validationMessage;

  void _validateAnswer() {
    String userAnswer = _answerController.text.trim().toLowerCase().replaceAll(' ', '');
    bool isCorrect = widget.puzzle.correctAnswers.any(
          (ans) => ans.toLowerCase().replaceAll(' ', '') == userAnswer,
    );

    setState(() {
      _validationMessage = isCorrect ? "Correct! Well done." : "Incorrect. Try again or view the solution.";
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.puzzle.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.puzzle.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                labelText: 'Enter your answer here',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _validateAnswer,
                  child: const Text('Check Answer'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Solution'),
                        content: Text(widget.puzzle.solution),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('View Solution'),
                ),
              ],
            ),
            if (_validationMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _validationMessage!,
                  style: TextStyle(
                    color: _validationMessage == "Correct! Well done."
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
