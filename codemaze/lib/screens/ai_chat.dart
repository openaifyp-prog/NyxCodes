import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/message_bubble.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/message_reactions.dart';
import '../providers/chat_provider.dart';

class AIChat extends StatefulWidget {
  const AIChat({super.key});

  @override
  State<AIChat> createState() => _AIChatState();
}

class _AIChatState extends State<AIChat> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final String openRouterApiKey = "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";
  bool isThinking = false;

  List<ChatMessage> messages = [];

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: text,
      timestamp: DateTime.now(),
      sender: Sender.user,
    );

    setState(() {
      messages.add(userMessage);
      isThinking = true;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
        headers: {
          "Authorization": "Bearer $openRouterApiKey",
          "Content-Type": "application/json",
          "HTTP-Referer": "https://yourapp.com", // Optional
          "X-Title": "CodeMaze C++ AI Assistant"
        },
        body: jsonEncode({
          "model": "mistralai/mistral-7b-instruct",
          "messages": [
            {"role": "system", "content": "You are a helpful assistant that explains C++ concepts."},
            {"role": "user", "content": text}
          ]
        }),
      );

      final data = jsonDecode(response.body);
      debugPrint("📦 OpenRouter response: ${jsonEncode(data)}");

      final aiText = data["choices"]?[0]?["message"]?["content"] ?? "⚠️ No response from AI.";

      final aiMessage = ChatMessage(
        text: aiText,
        timestamp: DateTime.now(),
        sender: Sender.ai,
      );

      setState(() {
        messages.add(aiMessage);
        isThinking = false;
      });
    } catch (e) {
      final errorMessage = ChatMessage(
        text: "❌ OpenRouter error: $e",
        timestamp: DateTime.now(),
        sender: Sender.ai,
      );
      setState(() {
        messages.add(errorMessage);
        isThinking = false;
      });
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showReactionPicker(int index) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ReactionPicker(
        onReactionSelected: (msgIndex, reaction) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Reacted with $reaction")),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("C++ AI Chat Assistant"),
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              itemCount: messages.length + (isThinking ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < messages.length) {
                  final msg = messages[index];
                  return GestureDetector(
                    onLongPress: () => _showReactionPicker(index),
                    child: Column(
                      crossAxisAlignment: msg.sender == Sender.user
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        MessageBubble(
                          message: msg,
                          isDarkMode: isDark,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const TypingIndicator();
                }
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: sendMessage,
                    decoration: InputDecoration(
                      hintText: "Ask something about C++...",
                      filled: true,
                      fillColor: Theme.of(context).dialogBackgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send_rounded),
                  onPressed: () => sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
