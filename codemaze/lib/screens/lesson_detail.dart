import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lesson.dart';

class LessonDetailPage extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailPage({Key? key, required this.lesson}) : super(key: key);

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    _checkIfCompleted();
  }

  Future<void> _checkIfCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList('completedLessons') ?? [];
    setState(() {
      isCompleted = completed.contains(widget.lesson.title);
    });
  }

  Future<void> _markAsCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList('completedLessons') ?? [];

    if (!completed.contains(widget.lesson.title)) {
      completed.add(widget.lesson.title);
      await prefs.setStringList('completedLessons', completed);
      setState(() {
        isCompleted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lesson marked as completed!')),
      );
      Navigator.pop(context, true); // return to lessons.dart and refresh
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lesson already completed.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              widget.lesson.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              widget.lesson.detailedExplanation,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Example:',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple.shade700),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.lesson.exampleCode,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Expected Output:',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple.shade700),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.lesson.expectedOutput,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 30),
            if (!isCompleted)
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text("Mark as Completed"),
                onPressed: _markAsCompleted,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              )
            else
              ElevatedButton.icon(
                icon: const Icon(Icons.verified),
                label: const Text("Completed"),
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  minimumSize: const Size(double.infinity, 50),
                ),
              )
          ],
        ),
      ),
    );
  }
}
