import 'package:flutter/material.dart';
import 'dart:math' as math;

class BubbleField extends StatefulWidget {
  final Color backgroundColor;
  final Color circleColor;
  final double animationSpeed;
  final double padding;
  final int gridSize;

  const BubbleField({
    super.key,
    this.backgroundColor = Colors.black,
    this.circleColor = Colors.white,
    this.animationSpeed = 1.0,
    this.padding = 25,
    this.gridSize = 100,
  });

  @override
  BubbleFieldState createState() => BubbleFieldState();
}

class BubbleFieldState extends State<BubbleField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<List<double>> points = [
    [1, 4],
    [-2, -1],
    [2, -4],
    [1, 2],
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _animate();
  }

  double _time = 0;
  void _animate() {
    if (!mounted) return;
    setState(() {
      _time += 0.016;
    });
    Future.delayed(const Duration(milliseconds: 16), _animate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Offset> _calculatePositions(Size size, double time) {
    const detail = 1000.0;
    return points.map((p) {
      final x = math.sin((math.pi / detail) * (time * p[0]));
      final y = math.sin((math.pi / detail) * (time * p[1]));
      return Offset(
        lerpDouble(widget.padding, size.width - widget.padding, (x + 1) / 2)!,
        lerpDouble(widget.padding, size.height - widget.padding, (y + 1) / 2)!,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: BubbleFieldPainter(
            frameCount: _time * 100 * widget.animationSpeed,
            backgroundColor: widget.backgroundColor,
            circleColor: widget.circleColor,
            gridSize: widget.gridSize,
            calculatePositions: _calculatePositions,
          ),
        );
      },
    );
  }
}

class BubbleFieldPainter extends CustomPainter {
  final double frameCount;
  final Color backgroundColor;
  final Color circleColor;
  final int gridSize;
  final List<Offset> Function(Size size, double time) calculatePositions;

  BubbleFieldPainter({
    required this.frameCount,
    required this.backgroundColor,
    required this.circleColor,
    required this.gridSize,
    required this.calculatePositions,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    final positions = calculatePositions(size, frameCount);
    final radius = size.width * 0.2;

    final viewWidth = size.width - 2;
    final viewHeight = size.height - 2;

    final xCount = viewWidth / gridSize;
    final yCount = viewHeight / gridSize;

    final circlePaint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int xVal = 1; xVal < gridSize; xVal++) {
      for (int yVal = 1; yVal < gridSize; yVal++) {
        final xOffset = yVal % 2 == 1 ? xCount / 4 : -xCount / 4;
        final x = (xVal * xCount) + xOffset;
        final y = (yVal * yCount);
        final point = Offset(x, y);

        int intersections = 0;
        for (final pos in positions) {
          if ((pos - point).distance < radius) {
            intersections++;
          }
        }

        if (intersections > 0) {
          final circleRadius =
              lerpDouble(2, xCount, intersections / positions.length)!;
          canvas.drawCircle(point, circleRadius / 2, circlePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(BubbleFieldPainter oldDelegate) {
    return oldDelegate.frameCount != frameCount;
  }
}

double? lerpDouble(num? a, num? b, double t) {
  if (a == null && b == null) return null;
  a ??= 0.0;
  b ??= 0.0;
  return a + (b - a) * t;
}
