import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _username = 'Guest User';
  String _email = 'No Email';
  String _avatar = '';

  String get username => _username;
  String get email => _email;
  String get avatar => _avatar;

  void setUsername(String name) {
    _username = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setAvatar(String path) {
    _avatar = path;
    notifyListeners();
  }
}
