// lib/screens/puzzle_page.dart
import 'package:flutter/material.dart';
import '../data/puzzles_data.dart';       // Only data import here
import '../models/puzzle.dart';
import 'puzzle_detail.dart';             // Import screens here
import 'puzzle_solve.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final categories = puzzleList.map((p) => p.category).toSet().toList();

    final filteredPuzzles = _selectedCategory == null
        ? puzzleList
        : puzzleList.where((p) => p.category == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Puzzles')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButton<String>(
              hint: const Text('Filter by Category'),
              value: _selectedCategory,
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedCategory = val),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPuzzles.length,
              itemBuilder: (context, index) {
                final puzzle = filteredPuzzles[index];
                return ListTile(
                  title: Text(puzzle.title),
                  subtitle: Text('Difficulty: ${puzzle.difficulty}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        child: const Text('Solve'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PuzzleSolvePage(puzzle: puzzle),
                            ),
                          );
                        },
                      ),
                      TextButton(
                        child: const Text('Solution'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PuzzleDetailPage(puzzle: puzzle),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
