import 'dart:math';

import 'package:flutter/material.dart';

class ConicGradient extends StatefulWidget {
  final double durationSeconds; // Duration of the animation in seconds
  final double maxDiameter; // Maximum diameter of the gradient
  final int steps; // Number of steps in the gradient

  const ConicGradient({
    Key? key,
    this.durationSeconds = 10,
    this.maxDiameter = 1.2,
    this.steps = 10,
  }) : super(key: key);

  @override
  // State creation for ConicGradient widget
  // ignore: library_private_types_in_public_api
  _ConicGradientState createState() => _ConicGradientState();
}

// State class for ConicGradient widget
class _ConicGradientState extends State<ConicGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  // Initialize state
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds.toInt()),
    )..repeat();
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
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi, // Rotation angle from 0 to 2*pi
          child: CustomPaint(
            painter: _ConicGradientPainter(
              angle: _controller.value * 360, // Convert to degrees
              steps: widget.steps,
            ),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}

// Custom painter for drawing conic gradient
class _ConicGradientPainter extends CustomPainter {
  final double angle;
  final int steps;

  _ConicGradientPainter({required this.angle, required this.steps});

  @override
  // Painting the canvas
  void paint(Canvas canvas, Size size) {
    final double maxDiameter = size.width * 1.2;
    final double stepSize = maxDiameter / 2 / steps;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw concentric rings with conic gradient effect
    for (double diameter = maxDiameter - stepSize;
        diameter > 0;
        diameter -= stepSize * 2) {
      canvas.save();
      canvas.translate(center.dx, center.dy);

      // Generate gradient colors and stops
      final List<Color> colors = _generateColors();
      final List<double> stops = _generateStops();
      final Gradient gradient = LinearGradient(
        colors: colors,
        stops: stops,
      );

      final Paint paint = Paint()..strokeWidth = stepSize;

      // Define a path as a rectangle
      final Path path = Path()
        ..addRect(Rect.fromCenter(
            center: Offset.zero, width: diameter, height: diameter));

      // Apply rotation
      path.transform(Matrix4.rotationZ(-angle * pi / 180).storage);

      // Draw gradient along the path
      canvas.drawPath(
        path,
        paint..shader = gradient.createShader(path.getBounds()),
      );
      canvas.restore();
    }
  }

  // Generate gradient colors
  List<Color> _generateColors() {
    List<Color> colors = [];
    bool alternate = false;
    for (int i = 0; i < 24; i++) {
      colors.add(alternate ? Colors.black : Colors.white);
      alternate = !alternate;
    }
    return colors;
  }

  // Generate gradient stops
  List<double> _generateStops() {
    List<double> stops = [];
    const double step = 1 / 24;
    for (int i = 0; i < 24; i++) {
      stops.add(i * step);
    }
    return stops;
  }

  @override
  // Check if repaint is needed
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
