import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedLinesGradient extends StatefulWidget {
  final double animationDuration;

  const AnimatedLinesGradient({
    super.key,
    this.animationDuration = 5,
  });

  @override
  AnimatedLinesGradientState createState() => AnimatedLinesGradientState();
}

class AnimatedLinesGradientState extends State<AnimatedLinesGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _t = 0.0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDuration.toInt()),
    )..repeat();
    _controller.addListener(() {
      setState(() {
        _t = _controller.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: LinesGradientPainter(_t),
          size: Size.infinite,
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

class LinesGradientPainter extends CustomPainter {
  final double t;

  LinesGradientPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.white, BlendMode.src);
    for (int i = 0; i < 10; i++) {
      double phase = i / 10 * 2 * math.pi;
      double y = size.height * (0.1 + 0.8 * i / 9) +
          math.sin(t * 2 * math.pi + phase) * size.height * 0.05;

      Path dashPath = Path();
      dashPath.moveTo(0, y);
      dashPath.lineTo(size.width, y);

      final dashPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width / 50
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(
          colors: [
            HSVColor.fromAHSV(1, (360 * t + i * 36) % 360, 1, 1).toColor(),
            HSVColor.fromAHSV(1, (360 * t + (i + 5) * 36) % 360, 1, 1)
                .toColor(),
          ],
        ).createShader(Rect.fromPoints(Offset.zero, Offset(size.width, 0)));

      canvas.drawPath(dashPath, dashPaint);
    }
  }

  @override
  bool shouldRepaint(LinesGradientPainter oldDelegate) {
    return oldDelegate.t != t;
  }
}
