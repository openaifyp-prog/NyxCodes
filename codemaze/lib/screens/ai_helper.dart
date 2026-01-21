import '../services/api_service.dart';

/// A simple wrapper around [ApiService] to handle conversation history.
class AiHelper {
  final List<String> _history = [];

  /// Send a new [message] to AI, keeping history if desired.
  Future<String> ask(String message) async {
    _history.add('You: $message');
    final reply = await ApiService.sendAiPrompt(message);
    _history.add('AI: $reply');
    return reply;
  }

  /// Retrieve full chat history.
  List<String> getHistory() => List.unmodifiable(_history);

  /// Clear conversation.
  void clear() => _history.clear();
}
