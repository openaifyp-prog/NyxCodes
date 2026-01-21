import 'package:flutter/material.dart';

class TimerBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0

  const TimerBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.purple.withOpacity(0.2),
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
      minHeight: 4,
    );
  }
}
