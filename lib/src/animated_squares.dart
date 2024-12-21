import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedSquares extends StatefulWidget {
  final double squareCount;
  final double animationDuration;
  final double strokeWidth;
  final List<Color> palette;

  const AnimatedSquares({
    super.key,
    this.squareCount = 20,
    this.animationDuration = 5,
    this.strokeWidth = 1.5,
    this.palette = const [
      Color(0xFFabcd5e),
      Color(0xFF14976b),
      Color(0xFF2b67af),
      Color(0xFF62b6de),
      Color(0xFFf589a3),
      Color(0xFFef562f),
      Color(0xFFfc8405),
      Color(0xFFf9d531),
    ],
  });

  @override
  AnimatedSquaresState createState() => AnimatedSquaresState();
}

class AnimatedSquaresState extends State<AnimatedSquares>
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
    return Container(
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: SquaresColoredPainter(
                  animationValue: _controller.value,
                  squareCount: widget.squareCount,
                  strokeWidth: widget.strokeWidth,
                  palette: widget.palette,
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SquaresColoredPainter extends CustomPainter {
  final double animationValue;
  final double squareCount;
  final double strokeWidth;
  final List<Color> palette;

  SquaresColoredPainter({
    required this.animationValue,
    required this.squareCount,
    required this.strokeWidth,
    required this.palette,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double sizeX = size.width / squareCount;
    final double sizeY = size.height / squareCount;
    final double s = min(sizeX, sizeY);

    final int countX = (size.width / s).ceil();
    final int countY = (size.height / s).ceil();

    for (var i = 0; i < countX; i++) {
      double x = i * s;
      for (var j = 0; j < countY; j++) {
        double y = j * s;

        final Offset center = Offset(x + s / 2, y + s / 2);
        final double d = center.distance;
        final double theta =
            atan2(center.dy - size.height / 2, center.dx - size.width / 2) +
                pi +
                d / 30;
        final double z = (sin(d / 20 - pi * 2 * animationValue) + 1) / 2;
        final double squareSize = z * s;

        final paint = Paint()
          ..color = _rainbow(theta / (2 * pi))
          ..style = PaintingStyle.fill;
        canvas.drawRect(
            Rect.fromCenter(
                center: center, width: squareSize, height: squareSize),
            paint);

        final strokePaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;
        canvas.drawRect(
            Rect.fromCenter(center: center, width: s, height: s), strokePaint);
      }
    }
  }

  @override
  bool shouldRepaint(SquaresColoredPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        squareCount != oldDelegate.squareCount ||
        strokeWidth != oldDelegate.strokeWidth ||
        palette != oldDelegate.palette;
  }

  Color _rainbow(double t) {
    final int i = (palette.length * t).floor();
    final double amt = (palette.length * t) % 1;
    return Color.lerp(
        palette[i % palette.length], palette[(i + 1) % palette.length], amt)!;
  }
}
