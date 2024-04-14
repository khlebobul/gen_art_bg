import 'dart:math' as math;
import 'package:flutter/material.dart';

class GridOfLines extends StatefulWidget {
  final double animationDuration;
  final int gridSize;
  final double strokeWidth;
  final Color color;

  const GridOfLines({
    Key? key,
    this.animationDuration = 5,
    this.gridSize = 10,
    this.strokeWidth = 0.015,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  // State creation for GridOfLines widget
  // ignore: library_private_types_in_public_api
  _GridOfLinesState createState() => _GridOfLinesState();
}

// State class for GridOfLines widget
class _GridOfLinesState extends State<GridOfLines>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  // Initialize state
  void initState() {
    super.initState();
    // Initialize animation controller with duration
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDuration.toInt()),
    )..repeat();
  }

  @override
  // Building the widget
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: GridPainter(
            animationValue: _controller.value,
            gridSize: widget.gridSize,
            strokeWidth: widget.strokeWidth,
            color: widget.color,
          ),
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

// Custom painter for drawing grid of lines
class GridPainter extends CustomPainter {
  final double animationValue;
  final int gridSize;
  final double strokeWidth;
  final Color color;

  GridPainter({
    required this.animationValue,
    required this.gridSize,
    required this.strokeWidth,
    required this.color,
  });

  @override
  // Painting the canvas
  void paint(Canvas canvas, Size size) {
    final dim = math.max(size.width, size.height);
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = dim * strokeWidth;

    final margin = dim * 0.1;
    final innerWidth = size.width - margin * 2;
    final cellSize = innerWidth / gridSize;

    final time = animationValue * 2 * math.pi;

    // Draw lines for the grid
    for (var y = 0; y < gridSize; y++) {
      for (var x = 0; x < gridSize; x++) {
        final u = gridSize <= 1 ? 0.5 : x / (gridSize - 1);
        final v = gridSize <= 1 ? 0.5 : y / (gridSize - 1);

        final px = margin + (size.width - margin * 2) * u;
        final py = margin + (size.height - margin * 2) * v;

        final rotation = math.sin(time + u * math.pi * 0.25) * math.pi;
        final lineSize = math.sin(time + v * math.pi) * 0.5 + 0.5;

        final dx = math.cos(rotation) * cellSize * lineSize / 2;
        final dy = math.sin(rotation) * cellSize * lineSize / 2;

        canvas.drawLine(
          Offset(px - dx, py - dy),
          Offset(px + dx, py + dy),
          paint,
        );
      }
    }
  }

  @override
  // Check if repaint is needed
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
