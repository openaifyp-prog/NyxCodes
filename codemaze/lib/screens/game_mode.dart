import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

// Import your 4 game pages here (adjust paths as per your project)
import 'quiz_game_page.dart';
import 'code_puzzle_challenge.dart';
import 'debugging_game_page.dart';
import 'syntax_speed_run_page.dart';

class GameModePage extends StatefulWidget {
  const GameModePage({Key? key}) : super(key: key);

  @override
  State<GameModePage> createState() => _GameModePageState();
}

class _GameModePageState extends State<GameModePage> {
  bool _isDarkMode = false;

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  final List<Map<String, dynamic>> gameChallenges = [];

  @override
  void initState() {
    super.initState();
    gameChallenges.addAll([
      {
        'title': 'C++ Quiz Challenge',
        'description': 'Answer rapid-fire C++ questions with a time limit.',
        'page': const QuizGamePage(),
      },
      {
        'title': 'Code Puzzle',
        'description': 'Solve tricky C++ coding puzzles with hints and scoring.',
        'page': const CodePuzzleChallenge(),
      },
      {
        'title': 'Debugging Game',
        'description': 'Find bugs in code snippets before time runs out.',
        'page': const DebuggingGamePage(),
      },
      {
        'title': 'Syntax Speed Run',
        'description': 'Type correct C++ syntax as fast as possible.',
        'page': const SyntaxSpeedRunPage(),
      },
      // Add more games here if needed
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Mode'),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          tooltip: 'Back to Home',
        ),
      ),
      drawer: AppDrawer(
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleDarkMode,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a challenge to improve your C++ skills in a fun, interactive way!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: gameChallenges.length,
                separatorBuilder: (context, index) => const Divider(height: 24),
                itemBuilder: (context, index) {
                  final challenge = gameChallenges[index];
                  return ListTile(
                    leading: const Icon(Icons.videogame_asset, color: Colors.deepPurple),
                    title: Text(challenge['title'] ?? ''),
                    subtitle: Text(challenge['description'] ?? ''),
                    trailing: ElevatedButton(
                      child: const Text('Start'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => challenge['page']),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
