import 'package:flutter/material.dart';

enum Sender { user, ai }

class ChatMessage {
  final String text;
  final Sender sender;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.sender,
    required this.timestamp,
  });
}

class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  void addUserMessage(String text) {
    _messages.add(ChatMessage(text: text, sender: Sender.user, timestamp: DateTime.now()));
    notifyListeners();
  }

  void addAIResponse(String text) {
    _messages.add(ChatMessage(text: text, sender: Sender.ai, timestamp: DateTime.now()));
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
