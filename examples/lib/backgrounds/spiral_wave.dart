import 'dart:math';

import 'package:flutter/material.dart';

class SpiralWave extends StatefulWidget {
  const SpiralWave({
    Key? key,
    this.size = 10, // Size of each circle
    this.k = 20, // Constant value for controlling wave effect
  }) : super(key: key);

  final double size; // Size of each circle
  final double k; // Constant value for controlling wave effect

  @override
  // ignore: library_private_types_in_public_api
  _SpiralWaveState createState() => _SpiralWaveState();
}

class _SpiralWaveState extends State<SpiralWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<List<Offset>> circles; // List of circles to be drawn
  late int cols, rows; // Number of columns and rows in the grid
  late double r; // Radius of the wave effect

  @override
  void initState() {
    super.initState();
    // Initialize animation controller with a duration of 5 seconds, set to repeat
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    cols = 0; // Initialize cols here
    circles = [];
    rows = 0; // Initialize rows here
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePatternPainter(
            circles: circles,
            animationValue: _controller.value,
            size: widget.size,
            k: widget.k,
          ),
          size: Size.infinite, // Paint within the infinite size of the widget
        );
      },
    );
  }
}

class WavePatternPainter extends CustomPainter {
  final List<List<Offset>> circles; // List of circles to be drawn
  final double animationValue; // Current value of the animation
  final double size; // Size of each circle
  final double k; // Constant value for controlling wave effect

  WavePatternPainter({
    required this.circles,
    required this.animationValue,
    required this.size,
    required this.k,
  });

  @override
  // ignore: avoid_renaming_method_parameters
  void paint(Canvas canvas, Size canvasSize) {
    final double width = canvasSize.width; // Width of the canvas
    final double height = canvasSize.height; // Height of the canvas

    final double centerWidth = width / 2; // Center width of the canvas
    final double centerHeight = height / 2; // Center height of the canvas

    final Paint paint = Paint()
      ..color = Colors.black // Circle color
      ..style = PaintingStyle.fill; // Fill style for the circles

    // Loop through each cell in the grid
    for (int i = 0; i < width / (size / 2); i++) {
      for (int j = 0; j < height / (size / 2); j++) {
        double x = size / 4 + i * (size / 2); // X-coordinate of the circle
        double y = size / 4 + j * (size / 2); // Y-coordinate of the circle
        double d = sqrt(pow(x - centerWidth, 2) +
            pow(y - centerHeight, 2)); // Distance from the center
        double angle =
            d / k + animationValue * 2 * pi; // Angle for the wave effect
        double xOffset = cos(angle) * d / k * 3; // X-offset for the wave effect
        double yOffset = sin(angle) * d / k * 3; // Y-offset for the wave effect
        // Draw a circle at the calculated position with a radius of size / 5
        canvas.drawCircle(
          Offset(x + xOffset, y + yOffset),
          size / 5,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(WavePatternPainter oldDelegate) {
    // Repaint only if the animation value changes
    return animationValue != oldDelegate.animationValue;
  }
}
