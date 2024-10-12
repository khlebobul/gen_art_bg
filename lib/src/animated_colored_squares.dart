import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedColoredSquares extends StatefulWidget {
  final double squareCount;
  final double animationDuration;
  final double strokeWidth;

  const AnimatedColoredSquares(
      {Key? key,
      this.squareCount = 20,
      this.animationDuration = 5,
      this.strokeWidth = 1.5})
      : super(key: key);

  @override
  AnimatedColoredSquaresState createState() => AnimatedColoredSquaresState();
}

class AnimatedColoredSquaresState extends State<AnimatedColoredSquares>
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

  SquaresColoredPainter({
    required this.animationValue,
    required this.squareCount,
    required this.strokeWidth,
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
        strokeWidth != oldDelegate.strokeWidth;
  }

  Color _rainbow(double t) {
    final List<Color> palette = [
      const Color(0xFFabcd5e),
      const Color(0xFF14976b),
      const Color(0xFF2b67af),
      const Color(0xFF62b6de),
      const Color(0xFFf589a3),
      const Color(0xFFef562f),
      const Color(0xFFfc8405),
      const Color(0xFFf9d531)
    ];
    final int i = (palette.length * t).floor();
    final double amt = (palette.length * t) % 1;
    return Color.lerp(
        palette[i % palette.length], palette[(i + 1) % palette.length], amt)!;
  }
}
