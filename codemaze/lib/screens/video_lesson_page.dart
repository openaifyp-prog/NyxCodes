import 'package:flutter/material.dart';
import 'video_player_page.dart';

class VideoLessonPage extends StatelessWidget {
  const VideoLessonPage({super.key});

  final List<Map<String, String>> lessons = const [
    {
      'title': 'Lesson 1: Introduction to C++',
      'videoPath': 'assets/videos/lesson1.mp4',
    },
    {
      'title': 'Lesson 2: Syntax and Structure',
      'videoPath': 'assets/videos/lesson2.mp4',
    },
    {
      'title': 'Lesson 3: Variables and Data Types',
      'videoPath': 'assets/videos/lesson3.mp4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Lessons')),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.play_circle_outline),
              title: Text(lesson['title']!),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VideoPlayerPage(
                      title: lesson['title']!,
                      videoPath: lesson['videoPath']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
