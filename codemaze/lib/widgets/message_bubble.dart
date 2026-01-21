import 'package:flutter/material.dart';
import '../providers/chat_provider.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isDarkMode;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == Sender.user;
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color = isUser
        ? Colors.deepPurple
        : (isDarkMode ? Colors.grey[700] : Colors.grey.shade300);
    final textColor = isUser
        ? Colors.white
        : (isDarkMode ? Colors.white70 : Colors.black87);
    final radius = isUser
        ? const BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
      bottomLeft: Radius.circular(16),
    )
        : const BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );

    return Container(
      alignment: alignment,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius,
        ),
        child: Column(
          crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(message.timestamp),
              style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return "${timestamp.hour.toString().padLeft(2,'0')}:${timestamp.minute.toString().padLeft(2,'0')}";
  }
}
