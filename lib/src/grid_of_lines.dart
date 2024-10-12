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
  GridOfLinesState createState() => GridOfLinesState();
}

class GridOfLinesState extends State<GridOfLines>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDuration.toInt()),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          color: Colors.white,
          child: CustomPaint(
            painter: GridPainter(
              animationValue: _controller.value,
              gridSize: widget.gridSize,
              strokeWidth: widget.strokeWidth,
              color: widget.color,
            ),
            size: Size.infinite,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

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
  void paint(Canvas canvas, Size size) {
    final dim = math.max(size.width, size.height);
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = dim * strokeWidth;

    final cellSize = size.width / gridSize;

    final time = animationValue * 2 * math.pi;

    for (var y = 0; y < gridSize; y++) {
      for (var x = 0; x < gridSize; x++) {
        final u = gridSize <= 1 ? 0.5 : x / (gridSize - 1);
        final v = gridSize <= 1 ? 0.5 : y / (gridSize - 1);

        final px = size.width * u;
        final py = size.height * v;

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
