import 'package:flutter/material.dart';
import 'dart:math' as math;

// Widget class for AnimatedLinesGradient
class AnimatedLinesGradient extends StatefulWidget {
  final double animationDuration;

  const AnimatedLinesGradient({
    Key? key,
    this.animationDuration = 5,
  }) : super(key: key);

  @override
  // State creation for AnimatedLinesGradient widget
  // ignore: library_private_types_in_public_api
  _AnimatedLinesGradientState createState() => _AnimatedLinesGradientState();
}

// State class for AnimatedLinesGradient widget
class _AnimatedLinesGradientState extends State<AnimatedLinesGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _t = 0.0;

  @override
  // Initialize state
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDuration.toInt()),
    )..repeat();
    _controller.addListener(() {
      setState(() {
        _t = (_controller.value * 100) % 2; // Update _t value for animation
      });
    });
    super.initState();
  }

  @override
  // Building the widget
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: LinesGradientPainter(_t), // Pass _t value to painter
          size: Size.infinite,
        );
      },
    );
  }

  @override
  // Dispose animation controller
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Custom painter for drawing animated lines with gradient effect
class LinesGradientPainter extends CustomPainter {
  final double t;

  LinesGradientPainter(this.t);

  @override
  // Painting the canvas
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey[500]!
      ..strokeWidth = size.width / 50;

    // Calculate the length of the dash based on time parameter t
    double ld = size.width /
        12 *
        (math.sin(math.cos(t / 2 * math.pi + math.pi / 4) *
                    (((t * 100) % (2 * math.pi)))) /
                2 +
            1 / 2);

    // Define paint for the dash line
    final dashPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = paint.strokeWidth;

    // Draw dash lines with gradient effect
    double y = ld - size.height;
    while (y < size.height * 2 + ld) {
      Path dashPath = Path();
      dashPath.moveTo(-ld, y);
      dashPath.lineTo(size.width + ld * 2, y);
      canvas.drawPath(
          dashPath,
          dashPaint
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.square
            ..strokeWidth = ld * 2
            // Create linear gradient shader for the dash line
            ..shader = const LinearGradient(
              colors: [Colors.white, Colors.black],
            ).createShader(
                Rect.fromPoints(Offset.zero, Offset(size.width, 0))));
      y += ld * 2;
    }
  }

  @override
  // Check if repaint is needed
  bool shouldRepaint(LinesGradientPainter oldDelegate) {
    return oldDelegate.t != t;
  }
}
