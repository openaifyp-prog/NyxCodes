import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lesson_content_provider.dart';
import '../models/lesson.dart';
import 'lesson_detail.dart';

class LessonsPage extends StatelessWidget {
  const LessonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonContentProvider>(context);
    final categories = lessonProvider.getCategories();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lessons'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
          ),
        ),
        body: ListView(
          children: categories.map((category) {
            final lessons = lessonProvider.getLessonsByCategory(category);
            return ExpansionTile(
              title: Text(category, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              children: lessons.map((lesson) {
                return ListTile(
                  title: Text(lesson.title),
                  subtitle: Text(lesson.shortDescription ?? ''),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LessonDetailPage(lesson: lesson),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
