import 'dart:math';
import 'package:flutter/material.dart';

// Widget class for AnimatedBWSquares
class AnimatedBWSquares extends StatefulWidget {
  final double squareCount;
  final double animationDuration;
  final double margin;
  final double strokeWidth;

  const AnimatedBWSquares(
      {Key? key,
      this.squareCount = 20,
      this.animationDuration = 5,
      this.margin = 50,
      this.strokeWidth = 1.5})
      : super(key: key);

  @override
  // State creation for AnimatedBWSquares widget
  // ignore: library_private_types_in_public_api
  _AnimatedBWSquaresState createState() => _AnimatedBWSquaresState();
}

// State class for AnimatedBWSquares widget
class _AnimatedBWSquaresState extends State<AnimatedBWSquares>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  // Initialize state
  void initState() {
    super.initState();
    // Initializing animation controller with duration and vsync
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDuration.toInt()),
    )..repeat();
  }

  @override
  // Building the widget
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(1000, 1000),
              painter: SquaresPainter(
                animationValue: _controller.value,
                squareCount: widget.squareCount,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  // Dispose animation controller
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Custom painter for drawing animated black and white squares
class SquaresPainter extends CustomPainter {
  final double animationValue;
  final double squareCount;

  SquaresPainter({
    required this.animationValue,
    required this.squareCount,
  });

  @override
  // Painting the canvas
  void paint(Canvas canvas, Size size) {
    const double margin = 50; // Margin around the canvas
    final double s =
        (size.width - 2 * margin) / squareCount; // Size of each square

    for (var i = 0; i < squareCount; i++) {
      double x = margin + i * s;
      for (var j = 0; j < squareCount; j++) {
        double y = margin + j * s;

        final Offset center = Offset(x + s / 2, y + s / 2);
        final double d = center.distance;
        final double theta =
            atan2(center.dy - size.height / 2, center.dx - size.width / 2) +
                pi +
                d / 30;
        final double z = (sin(d / 20 - pi * 2 * animationValue) + 1) / 2;
        final double squareSize = z * s;

        // Drawing the square
        final paint = Paint()
          ..color = _rainbow(theta / (2 * pi)) // Coloring the square
          ..style = PaintingStyle.fill;
        canvas.drawRect(
            Rect.fromCenter(center: center, width: squareSize, height: s),
            paint);

        // Drawing the border of the square
        final strokePaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        canvas.drawRect(
            Rect.fromCenter(center: center, width: s, height: s), strokePaint);
      }
    }
  }

  @override
  // Check if repaint is needed
  bool shouldRepaint(SquaresPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        squareCount != oldDelegate.squareCount;
  }

  // Function to generate rainbow colors based on input parameter t
  Color _rainbow(double t) {
    final List<Color> palette = [
      const Color(0xFF000000), // Black
      const Color(0xFF000000), // Black
      const Color(0xFF000000), // Black
      const Color(0xFF000000), // Black
      const Color(0xFF000000), // Black
      const Color(0xFF000000), // Black
      const Color(0xFF000000), // Black
      const Color(0xFF000000) // Black
    ];
    final int i = (palette.length * t).floor();
    final double amt = (palette.length * t) % 1;
    return Color.lerp(
        palette[i % palette.length], palette[(i + 1) % palette.length], amt)!;
  }
}
