import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaveField extends StatefulWidget {
  final double gridStep;
  final Color backgroundColor;
  final Color squareColor;
  final double animationSpeed;

  const WaveField({
    super.key,
    this.gridStep = 16,
    this.backgroundColor = Colors.black,
    this.squareColor = Colors.white,
    this.animationSpeed = 1.0,
  });

  @override
  WaveFieldState createState() => WaveFieldState();
}

class WaveFieldState extends State<WaveField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _calculatePanelSize(double x, double y, double frameCount) {
    final rotX = math.sin((frameCount + (y / 10)) / 60);
    final rotY = math.cos((frameCount + (y / 10)) / 30);

    final modX = x * rotX;
    final modY = y * rotY;

    final offsetScale =
        widget.gridStep * (math.sin(frameCount / 100) * 4.5 + 5.5);

    final offset = (modX + modY) / offsetScale;
    final panelSize = (math.sin((frameCount / 30) + offset) * 0.5 + 0.5) *
        (widget.gridStep - 2);

    return panelSize;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: WaveFieldPainter(
                frameCount: _controller.value * 379 * widget.animationSpeed,
                gridStep: widget.gridStep,
                backgroundColor: widget.backgroundColor,
                squareColor: widget.squareColor,
                calculatePanelSize: _calculatePanelSize,
              ),
            );
          },
        );
      },
    );
  }
}

class WaveFieldPainter extends CustomPainter {
  final double frameCount;
  final double gridStep;
  final Color backgroundColor;
  final Color squareColor;
  final double Function(double x, double y, double frameCount)
      calculatePanelSize;

  WaveFieldPainter({
    required this.frameCount,
    required this.gridStep,
    required this.backgroundColor,
    required this.squareColor,
    required this.calculatePanelSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    final squarePaint = Paint()
      ..color = squareColor
      ..style = PaintingStyle.fill;

    for (double x = gridStep; x < size.width; x += gridStep) {
      for (double y = gridStep; y < size.height; y += gridStep) {
        final panelSize = calculatePanelSize(x, y, frameCount);

        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(x, y),
            width: panelSize,
            height: panelSize,
          ),
          squarePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(WaveFieldPainter oldDelegate) {
    return oldDelegate.frameCount != frameCount;
  }
}
