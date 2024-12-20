import 'dart:math';

import 'package:flutter/material.dart';

class SpiralWave extends StatefulWidget {
  const SpiralWave({
    super.key,
    this.size = 10,
    this.k = 20,
  });

  final double size;
  final double k;

  @override
  SpiralWaveState createState() => SpiralWaveState();
}

class SpiralWaveState extends State<SpiralWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<List<Offset>> circles;
  late int cols, rows;
  late double r;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    cols = 0;
    circles = [];
    rows = 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: WavePatternPainter(
              circles: circles,
              animationValue: _controller.value,
              size: widget.size,
              k: widget.k,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class WavePatternPainter extends CustomPainter {
  final List<List<Offset>> circles;
  final double animationValue;
  final double size;
  final double k;

  WavePatternPainter({
    required this.circles,
    required this.animationValue,
    required this.size,
    required this.k,
  });

  @override

  // ignore: avoid_renaming_method_parameters
  void paint(Canvas canvas, Size canvasSize) {
    final double width = canvasSize.width;
    final double height = canvasSize.height;

    final double centerWidth = width / 2;
    final double centerHeight = height / 2;

    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    for (int i = 0; i < width / (size / 2); i++) {
      for (int j = 0; j < height / (size / 2); j++) {
        double x = size / 4 + i * (size / 2);
        double y = size / 4 + j * (size / 2);
        double d = sqrt(pow(x - centerWidth, 2) + pow(y - centerHeight, 2));
        double angle = d / k + animationValue * 2 * pi;
        double xOffset = cos(angle) * d / k * 3;
        double yOffset = sin(angle) * d / k * 3;

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
    return animationValue != oldDelegate.animationValue;
  }
}
