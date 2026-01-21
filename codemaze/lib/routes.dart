import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/home.dart';
import 'screens/game_mode.dart';
import 'screens/lessons.dart';
import 'screens/ai_chat.dart';
import 'screens/compiler_page.dart';
import 'screens/video_lesson_page.dart';
import 'screens/progress_page.dart';
import 'screens/puzzle_page.dart';
import 'screens/code_puzzle_challenge.dart';
import 'package:codemaze/screens/profile.dart' as profile;
import 'package:codemaze/screens/settings.dart' as settings;


final Map<String, WidgetBuilder> appRoutes = {
  // Removed '/' route here because home: is used in main.dart

  '/onboarding': (_) => const OnboardingScreen(),
  '/login': (_) => const LoginPage(),
  '/signup': (_) => const SignupPage(),
  '/home': (context) => const HomePage(),
  '/lessons': (_) => const LessonsPage(),
  '/ai_chat': (_) => const AIChat(),
  '/compiler': (context) => const CompilerPage(),
  '/progress': (_) => const ProgressPage(),
  '/profile': (_) => const profile.Profile(),
  '/settings': (_) => const settings.SettingsPage(),
  // Games and puzzles

  '/game_mode': (_) => const GameModePage(),
  '/puzzles': (_) => const PuzzlePage(),
  '/game_code_puzzle': (_) => const CodePuzzleChallenge(),
  '/video_lesson_page': (_) => const VideoLessonPage(),
};
