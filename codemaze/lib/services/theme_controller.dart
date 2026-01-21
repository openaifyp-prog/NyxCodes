import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'theme_service.dart';

class ThemeController extends ValueNotifier<AppTheme> {
  ThemeController(AppTheme initial) : super(initial);

  ThemeData resolveThemeData(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        );
      case AppTheme.dark:
        return ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSwatch(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
          ),
        );
      case AppTheme.oceanBlue:
        return ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.teal,
          scaffoldBackgroundColor: Colors.teal.shade50,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
        );
      case AppTheme.highContrast:
        return ThemeData(
          brightness: Brightness.light, // no highContrastLight constant
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          colorScheme: ColorScheme.highContrastLight(),
        );
      case AppTheme.system:
      default:
        return ThemeData.fallback();
    }
  }

  Future<void> load() async {
    value = await ThemeService.loadTheme();
  }

  Future<void> setTheme(AppTheme theme) async {
    value = theme;
    await ThemeService.saveTheme(theme);
  }
}
