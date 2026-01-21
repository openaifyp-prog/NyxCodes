import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundProvider with ChangeNotifier {
  bool _soundEnabled = true;

  bool get soundEnabled => _soundEnabled;

  SoundProvider() {
    _loadSoundPreference();
  }

  Future<void> _loadSoundPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _soundEnabled = prefs.getBool('soundEnabled') ?? true;
    notifyListeners();
  }

  void toggleSound(bool enabled) async {
    _soundEnabled = enabled;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', enabled);
  }
}
