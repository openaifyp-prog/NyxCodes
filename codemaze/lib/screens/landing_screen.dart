import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  final VoidCallback onContinue;

  const LandingScreen({Key? key, required this.onContinue}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 4), () {
      widget.onContinue();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _codeBracket(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple.shade400,
        shadows: [
          Shadow(
            color: Colors.deepPurple.shade200,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseFontSize = MediaQuery.of(context).size.width < 350 ? 36.0 : 48.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _codeBracket('<'),
              const SizedBox(width: 8),
              Text(
                'CodeMaze',
                style: TextStyle(
                  fontSize: baseFontSize,
                  fontWeight: FontWeight.w900,
                  color: Colors.deepPurple,
                  letterSpacing: 6,
                  shadows: [
                    Shadow(
                      color: Colors.deepPurple.shade100,
                      blurRadius: 15,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _codeBracket('/>'),
            ],
          ),
        ),
      ),
    );
  }
}
