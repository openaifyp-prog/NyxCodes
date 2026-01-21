import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/onboarding_screen.dart';
import 'screens/landing_screen.dart';

import 'firebase_options.dart';
import 'providers/lesson_content_provider.dart';
import 'providers/quiz_provider.dart';
import 'providers/puzzle_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/progress_provider.dart';
import 'providers/sound_provider.dart';
import 'providers/font_provider.dart';
import 'providers/user_provider.dart';
import 'routes.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _initializeNotifications() async {
  tz.initializeTimeZones(); // ✅ Timezone init required for schedule
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(settings);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _initializeNotifications(); // 🔔 Local notification setup
  runApp(const CodeMazeApp());
}

class CodeMazeApp extends StatefulWidget {
  const CodeMazeApp({super.key});

  @override
  State<CodeMazeApp> createState() => _CodeMazeAppState();
}

class _CodeMazeAppState extends State<CodeMazeApp> {
  bool _showLanding = false;
  bool _showOnboarding = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunchAndLogin();
  }

  Future<void> _checkFirstLaunchAndLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool('onboarding_done') ?? false;
    final landingDone = prefs.getBool('landing_done') ?? false;
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        _showLanding = false;
        _showOnboarding = false;
        _isLoading = false;
      });
    } else {
      setState(() {
        _showLanding = !landingDone;
        _showOnboarding = landingDone && !onboardingDone;
        _isLoading = false;
      });
    }
  }

  void _onLandingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('landing_done', true);
    setState(() {
      _showLanding = false;
      _showOnboarding = true;
    });
  }

  void _onOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    setState(() {
      _showOnboarding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        debugShowCheckedModeBanner: false,
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LessonContentProvider()..loadLessons()),
        ChangeNotifierProvider(create: (_) => QuizProvider()..loadQuizzes()),
        ChangeNotifierProvider(create: (_) => PuzzleProvider()..loadPuzzles()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider<SoundProvider>(create: (_) => SoundProvider()),
        ChangeNotifierProvider<FontProvider>(create: (_) => FontProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Builder(builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final fontProvider = Provider.of<FontProvider>(context);

        // ✅ Apply font scaling using MediaQuery
        double scale;
        switch (fontProvider.fontSize) {
          case 'Small':
            scale = 0.85;
            break;
          case 'Large':
            scale = 1.25;
            break;
          default:
            scale = 1.0;
        }

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CodeMaze - Learn C++',
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.deepPurple,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.deepPurple,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: _showLanding
                ? LandingScreen(onContinue: _onLandingComplete)
                : _showOnboarding
                ? OnboardingScreen(onFinish: _onOnboardingComplete)
                : StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasData) {
                  return const HomePage();
                } else {
                  return const LoginPage();
                }
              },
            ),
            routes: appRoutes,
          ),
        );
      }),
    );
  }
}
