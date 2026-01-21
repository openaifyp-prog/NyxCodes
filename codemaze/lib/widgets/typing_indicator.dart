import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({Key? key}) : super(key: key);

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat();

    _animation1 = Tween<double>(begin: 0.3, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.7)),
    );
    _animation2 = Tween<double>(begin: 0.3, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.9)),
    );
    _animation3 = Tween<double>(begin: 0.3, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: Dot(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(_animation1),
            _buildDot(_animation2),
            _buildDot(_animation3),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 6,
      height: 6,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
