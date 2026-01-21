import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/app_drawer.dart';
import '../providers/lesson_content_provider.dart';
import 'puzzle_page.dart'; // Adjust if needed
import 'lessons.dart';
import 'package:codemaze/screens/profile.dart' as profile;
import 'package:codemaze/screens/settings.dart' as settings;
import 'progress_page.dart';
import 'ai_chat.dart';
import 'compiler_page.dart';
import 'video_lesson_page.dart'; // QuizPage import
import '../providers/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeDashboard(),
    const LessonsPage(),
    const profile.Profile(),
    const settings.SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      drawer: AppDrawer(
        isDarkMode: themeProvider.isDarkMode,
        onThemeChanged: (bool value) => themeProvider.toggleDarkMode(value),
      ),
      appBar: AppBar(
        title: const Text('CodeMaze'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            tooltip: themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
            onPressed: () => themeProvider.toggleDarkMode(!themeProvider.isDarkMode),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 8,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Lessons'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.white,
    );
  }
}

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // ignore: avoid_print
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonContentProvider>(context);
    final categories = lessonProvider.getCategories();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildBanner(),
            const SizedBox(height: 16),
            _buildMotivationalQuote(),
            const SizedBox(height: 16),
            _buildQuickActions(context),
            const SizedBox(height: 24),
            _buildRecentLessons(context),
            const SizedBox(height: 24),
            _buildFeaturedLessons(context, categories),
            const SizedBox(height: 24),
            _buildUpcomingEvents(context, isDark),
            const SizedBox(height: 24),
            _buildTipsAndTricks(context, isDark),
            const SizedBox(height: 24),
            _buildDailyChallenge(context),
            const SizedBox(height: 32),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: isDark ? Colors.deepPurple.shade800 : Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'Master C++ One Lesson at a Time!\nStay Consistent. Stay Motivated.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.deepPurple.shade900,
          ),
        ),
      ),
    );
  }

  Widget _buildMotivationalQuote() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.deepPurple.shade900 : Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "Learning C++ today paves your path to tomorrow's innovations.",
        style: TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
          color: isDark ? Colors.white70 : Colors.deepPurple.shade700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

// In the _buildQuickActions widget:
  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _quickActionTile(context, Icons.play_circle_fill, 'Video Lessons', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VideoLessonPage()),
          );
        }),
        _quickActionTile(context, Icons.extension, 'Puzzle', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PuzzlePage()));
        }),
        _quickActionTile(context, Icons.chat, 'AI Chat', () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AIChat()));
        }),
      ],
    );
  }


  Widget _quickActionTile(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.deepPurple.shade100,
            child: Icon(icon, size: 30, color: Colors.deepPurple),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildRecentLessons(BuildContext context) {
    final recentLessons = [
      'Introduction to Variables',
      'Control Flow Basics',
      'Functions and Parameters',
      'Pointers Explained',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recent Lessons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...recentLessons.map((lesson) => ListTile(
          leading: const Icon(Icons.book, color: Colors.deepPurple),
          title: Text(lesson),
          trailing: SizedBox(
            width: 100,
            child: LinearProgressIndicator(
              value: 0.6,
              color: Colors.deepPurple,
              backgroundColor: Colors.deepPurple.shade100,
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const LessonsPage()));
          },
        )),
      ],
    );
  }

  Widget _buildFeaturedLessons(BuildContext context, List<String> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Featured Lessons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return _featuredLessonCard(context, categories[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _featuredLessonCard(BuildContext context, String category) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const LessonsPage()));
            },
            child: const Text('Start Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEvents(BuildContext context, bool isDark) {
    final cardColor = isDark ? Colors.deepPurple.shade700 : Colors.deepPurple.shade50;
    return Card(
      color: cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.event, color: isDark ? Colors.white : Colors.deepPurple),
        title: const Text('Upcoming Webinar: Advanced C++ Tips'),
        subtitle: const Text('Join us on May 30th at 7 PM'),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.deepPurple.shade300 : Colors.deepPurple,
          ),
          onPressed: () => _launchUrl('https://www.eventbrite.com/d/online/c-plus-plus-webinar/'),
          child: const Text('Join Webinar'),
        ),
      ),
    );
  }

  Widget _buildTipsAndTricks(BuildContext context, bool isDark) {
    final cardColor = isDark ? Colors.deepPurple.shade700 : Colors.deepPurple.shade50;
    return Card(
      color: cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.lightbulb, color: isDark ? Colors.yellow.shade300 : Colors.amber),
        title: const Text('Tips & Tricks'),
        subtitle: const Text('Use references for better performance in your C++ code.'),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.deepPurple.shade300 : Colors.deepPurple,
          ),
          onPressed: () => _launchUrl('https://www.learncpp.com/'),
          child: const Text('Learn More'),
        ),
      ),
    );
  }

  Widget _buildDailyChallenge(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.star, color: Colors.deepPurple),
        title: const Text('Daily Challenge: Solve 5 Puzzles'),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PuzzlePage()));
          },
          child: const Text('Start'),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'CodeMaze v1.0.0\n© 2025 Your Name',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
