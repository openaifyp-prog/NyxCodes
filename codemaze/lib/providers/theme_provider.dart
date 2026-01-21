import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme {
  System,
  Light,
  Dark,
  PurplePink,
  BlueGrey,
  GreenFresh,
  DeepOrange,
}

class ThemeProvider with ChangeNotifier {
  AppTheme _selectedTheme = AppTheme.System;

  AppTheme get selectedTheme => _selectedTheme;

  bool get isDarkMode => _selectedTheme == AppTheme.Dark;

  ThemeProvider() {
    _loadTheme();
  }

  void setTheme(AppTheme theme) {
    _selectedTheme = theme;
    _saveTheme(theme);
    notifyListeners();
  }

  // ✅ Backward compatibility for dark mode toggles
  void toggleDarkMode(bool value) {
    setTheme(value ? AppTheme.Dark : AppTheme.Light);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('selectedTheme') ?? 0;
    _selectedTheme = AppTheme.values[themeIndex];
    notifyListeners();
  }

  Future<void> _saveTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedTheme', theme.index);
  }

  ThemeData getThemeData(String fontSize) {
    double scale;
    switch (fontSize) {
      case "Small":
        scale = 12;
        break;
      case "Large":
        scale = 20;
        break;
      default:
        scale = 16;
    }

    TextTheme baseText = TextTheme(
      bodyLarge: TextStyle(fontSize: scale),
      bodyMedium: TextStyle(fontSize: scale),
      bodySmall: TextStyle(fontSize: scale - 2),
    );

    switch (_selectedTheme) {
      case AppTheme.Light:
        return ThemeData.light().copyWith(textTheme: baseText);
      case AppTheme.Dark:
        return ThemeData.dark().copyWith(textTheme: baseText);
      case AppTheme.PurplePink:
        return ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.pink.shade50,
          textTheme: baseText,
        );
      case AppTheme.BlueGrey:
        return ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.grey.shade100,
          textTheme: baseText,
        );
      case AppTheme.GreenFresh:
        return ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.green.shade50,
          textTheme: baseText,
        );
      case AppTheme.DeepOrange:
        return ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.orange.shade50,
          textTheme: baseText,
        );
      case AppTheme.System:
      default:
        return ThemeData(
          textTheme: baseText,
        );
    }
  }
}
