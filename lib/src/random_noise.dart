import 'dart:math';
import 'package:flutter/material.dart';

class RandomNoise extends StatefulWidget {
  final Duration duration;
  final double dotSize;
  final double dotSpacing;

  const RandomNoise({
    super.key,
    this.duration = const Duration(seconds: 10),
    this.dotSize = 13,
    this.dotSpacing = 11,
  });

  @override
  RandomNoiseState createState() => RandomNoiseState();
}

class RandomNoiseState extends State<RandomNoise>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: AnimatedCanvasPainter(
        animationValue: _animation.value,
        dotSize: widget.dotSize,
        dotSpacing: widget.dotSpacing,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedCanvasPainter extends CustomPainter {
  final double animationValue;
  final double dotSize;
  final double dotSpacing;

  AnimatedCanvasPainter({
    required this.animationValue,
    required this.dotSize,
    required this.dotSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint redPaint = Paint()..color = Colors.red;
    Paint greenPaint = Paint()..color = Colors.green;
    Paint bluePaint = Paint()..color = Colors.blue;

    canvas.drawColor(Colors.black, BlendMode.src);

    for (double y = 0; y < size.height; y += dotSpacing) {
      for (double x = 0; x < size.width; x += dotSpacing) {
        if (f(x, y, animationValue)) {
          canvas.drawRect(Rect.fromLTWH(x, y, dotSize, dotSize), redPaint);
          canvas.drawRect(
              Rect.fromLTWH(x + dotSize / 2, y, dotSize, dotSize), greenPaint);
          canvas.drawRect(
              Rect.fromLTWH(x + dotSize / 3, y, dotSize, dotSize), bluePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  bool f(double x, double y, double t) {
    Random random = Random();
    int k = (random.nextDouble() * 100).round();
    return k % 2 == 1;
  }
}
