import 'package:flutter/material.dart';
import 'dart:math' as math;

// Widget class for AnimatedLines
class AnimatedLines extends StatefulWidget {
  final double animationDuration;
  final int numberOfLines;
  final double lineLength;
  final Color lineColor;
  final double strokeWidth;

  const AnimatedLines({
    Key? key,
    this.animationDuration = 10,
    this.numberOfLines = 30,
    this.lineLength = 250,
    this.lineColor = Colors.black,
    this.strokeWidth = 5,
  }) : super(key: key);

  @override
  // State creation for AnimatedLines widget
  // ignore: library_private_types_in_public_api
  _AnimatedLinesState createState() => _AnimatedLinesState();
}

// State class for AnimatedLines widget
class _AnimatedLinesState extends State<AnimatedLines>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  // Initialize state
  void initState() {
    super.initState();

    // Initialize animation controller with duration
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDuration.toInt()),
    );

    // Define animation using Tween
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        // Trigger a rebuild when animation value changes
        setState(() {
          // Update the widget state on each animation frame
        });
      });

    // Start the animation
    _controller.repeat(reverse: true);
  }

  @override
  // Dispose animation controller
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  // Building the widget
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: LinesPainter(
            animationValue: _animation.value,
            numberOfLines: widget.numberOfLines,
            lineLength: widget.lineLength,
            lineColor: widget.lineColor,
            strokeWidth: widget.strokeWidth,
          ), // Pass animation value to painter
          size: Size.infinite,
        );
      },
    );
  }
}

// Custom painter for drawing animated lines
class LinesPainter extends CustomPainter {
  final double animationValue;
  final int numberOfLines;
  final double lineLength;
  final Color lineColor;
  final double strokeWidth;

  LinesPainter({
    required this.animationValue,
    required this.numberOfLines,
    required this.lineLength,
    required this.lineColor,
    required this.strokeWidth,
  });

  @override
  // Painting the canvas
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = lineColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double gridSize = size.width / numberOfLines;

    // Draw lines with sinusoidal animation
    for (int i = 0; i < numberOfLines; i++) {
      Path path = Path();
      for (int j = 0; j < numberOfLines; j++) {
        double alpha = math.sin(0.1 * i + animationValue * 2 * math.pi) *
            math.cos(0.1 * j + animationValue * 2 * math.pi);
        double x = gridSize * j;
        double y = gridSize * i + lineLength * alpha;
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  // Check if repaint is needed
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
