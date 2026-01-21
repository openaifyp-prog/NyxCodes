import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  int lessonsCompleted = 0;
  int totalLessons = 40;
  int puzzlesSolved = 0;
  int totalPuzzles = 240;
  int quizzesSolved = 0;
  int debugChallengesSolved = 0;
  int syntaxRunsCompleted = 0;

  bool dailyChallengeDone = false;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lessonsCompleted = prefs.getInt('lessonsCompleted') ?? 0;
      puzzlesSolved = prefs.getInt('puzzlesSolved') ?? 0;
      quizzesSolved = prefs.getInt('quizzesPassed') ?? 0;
      debugChallengesSolved = prefs.getInt('debugChallengesSolved') ?? 0;
      syntaxRunsCompleted = prefs.getInt('syntaxRunsCompleted') ?? 0;
    });

    final today = DateTime.now().toIso8601String().substring(0, 10);
    final daily = prefs.getStringList('dailyPuzzleLog_$today') ?? [];
    setState(() {
      dailyChallengeDone = daily.length >= 5;
    });
  }

  Widget _buildProgressBar(String label, int completed, int total, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label: $completed / $total',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: total == 0 ? 0 : completed / total,
              minHeight: 8,
              color: color,
              backgroundColor: color.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Progress'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          const SizedBox(height: 12),
          _buildProgressBar('Lessons Completed', lessonsCompleted, totalLessons, Colors.deepPurple),
          _buildProgressBar('Puzzles Solved', puzzlesSolved, totalPuzzles, Colors.orange),
          const SizedBox(height: 20),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: dailyChallengeDone ? Colors.green : Colors.red.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                dailyChallengeDone
                    ? '✅ Daily Challenge Completed!'
                    : '⏳ Solve 5 puzzles today to complete the Daily Challenge!',
                style: TextStyle(
                  color: dailyChallengeDone ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '🎮 Gaming Stats',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          _buildProgressBar('🧩 Puzzles Solved', puzzlesSolved, totalPuzzles, Colors.orange),
          _buildProgressBar('❓ Quizzes Completed', quizzesSolved, 180, Colors.blue),
          _buildProgressBar('🐞 Debug Challenges', debugChallengesSolved, 120, Colors.red),
          _buildProgressBar('⌨️ Syntax Speed Runs', syntaxRunsCompleted, 300, Colors.teal),
          const SizedBox(height: 30),
          Center(
            child: Text(
              'Stay consistent. You’re leveling up your C++ mastery! 💪',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
