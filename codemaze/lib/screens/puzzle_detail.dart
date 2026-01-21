import 'package:flutter/material.dart';
import '../models/puzzle.dart';

class PuzzleDetailPage extends StatelessWidget {
  final Puzzle puzzle;

  const PuzzleDetailPage({Key? key, required this.puzzle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(puzzle.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Description:', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(puzzle.description, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 24),

            Text('Hint:', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(puzzle.hint, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 24),

            Text('Solution:', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(puzzle.solution, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
