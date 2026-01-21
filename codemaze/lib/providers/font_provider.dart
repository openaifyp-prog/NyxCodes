import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontProvider extends ChangeNotifier {
String _fontSize = "Medium";
String get fontSize => _fontSize;

void setFontSize(String size) {
  _fontSize = size;
  notifyListeners();
}

double get scale {
  switch (_fontSize) {
    case "Small": return 0.85;
    case "Large": return 1.25;
    default: return 1.0;
  }
}
}

