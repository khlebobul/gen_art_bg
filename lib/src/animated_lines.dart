import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedLines extends StatefulWidget {
  final double animationDuration;
  final int numberOfLines;
  final double lineLength;
  final Color lineColor;
  final double strokeWidth;

  const AnimatedLines({
    super.key,
    this.animationDuration = 10,
    this.numberOfLines = 30,
    this.lineLength = 250,
    this.lineColor = Colors.black,
    this.strokeWidth = 5,
  });

  @override
  AnimatedLinesState createState() => AnimatedLinesState();
}

class AnimatedLinesState extends State<AnimatedLines>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDuration.toInt()),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          color: Colors.white,
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: CustomPaint(
            painter: LinesPainter(
              animationValue: _animation.value,
              numberOfLines: widget.numberOfLines,
              lineLength: widget.lineLength,
              lineColor: widget.lineColor,
              strokeWidth: widget.strokeWidth,
              screenSize: Size(constraints.maxWidth, constraints.maxHeight),
            ),
          ),
        );
      },
    );
  }
}

class LinesPainter extends CustomPainter {
  final double animationValue;
  final int numberOfLines;
  final double lineLength;
  final Color lineColor;
  final double strokeWidth;
  final Size screenSize;

  LinesPainter({
    required this.animationValue,
    required this.numberOfLines,
    required this.lineLength,
    required this.lineColor,
    required this.strokeWidth,
    required this.screenSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = lineColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double gridSizeX = screenSize.width / (numberOfLines - 1);
    final double gridSizeY = screenSize.height / numberOfLines;

    for (int i = 0; i < numberOfLines; i++) {
      Path path = Path();
      for (int j = 0; j < numberOfLines; j++) {
        double alpha = math.sin(0.1 * i + animationValue * 2 * math.pi) *
            math.cos(0.1 * j + animationValue * 2 * math.pi);
        double x = gridSizeX * j;
        double y = gridSizeY * i + lineLength * alpha;
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
