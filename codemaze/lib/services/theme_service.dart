import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';

class ThemeService {
  static const _themeKey = 'appTheme';

  static Future<AppTheme> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_themeKey);
    return AppTheme.values.firstWhere(
          (t) => t.toString() == str,
      orElse: () => AppTheme.system,
    );
  }

  static Future<void> saveTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme.toString());
  }
}
