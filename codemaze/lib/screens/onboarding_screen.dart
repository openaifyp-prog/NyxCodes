import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback? onFinish;

  const OnboardingScreen({Key? key, this.onFinish}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Learn C++ Interactively',
      'description':
      'Master C++ with real-time code samples, examples, and explanations.',
      'image': 'assets/images/learn_cpp.png',
    },
    {
      'title': 'Gamified Learning',
      'description':
      'Challenge yourself with quizzes and puzzles to reinforce your knowledge.',
      'image': 'assets/images/gamified_learning.png',
    },
    {
      'title': 'Track Your Progress',
      'description':
      'Monitor your achievements and keep your learning streak alive!',
      'image': 'assets/images/track_progress.png',
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      if (widget.onFinish != null) {
        widget.onFinish!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      data['image']!,
                      height: 250,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      data['title']!,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      data['description']!,
                      style:
                      const TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 40,
            left: 32,
            right: 32,
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _currentPage == onboardingData.length - 1
                    ? 'Get Started'
                    : 'Next',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
