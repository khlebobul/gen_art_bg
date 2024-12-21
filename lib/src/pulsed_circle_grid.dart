import 'dart:math';
import 'package:flutter/material.dart';

class PulsedCircleGrid extends StatefulWidget {
  const PulsedCircleGrid({
    super.key,
    this.numberOfColumns = 12,
    this.circleDiameter = 27,
    this.animationDuration = const Duration(seconds: 5),
  });

  final int numberOfColumns;
  final double circleDiameter;
  final Duration animationDuration;

  @override
  PulsedCircleGridState createState() => PulsedCircleGridState();
}

class PulsedCircleGridState extends State<PulsedCircleGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<List<double>> tilts;
  late List<List<double>> levels;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeGrid(Size size) {
    final n = widget.numberOfColumns;
    final cellWidth = size.width / n;
    final numberOfRows = (size.height / cellWidth).ceil();

    tilts = [];
    levels = [];

    for (int i = 0; i < n; i++) {
      double x = (i + 0.5) * cellWidth;
      List<double> levelLine = [];
      List<double> tiltLine = [];
      for (int j = 0; j < numberOfRows; j++) {
        double y = (j + 0.5) * cellWidth;
        levelLine.add(
            sqrt(pow(x - size.width / 2, 2) + pow(y - size.height / 2, 2)) /
                (size.width / 24));
        tiltLine.add(atan2(y - size.height / 2, x - size.width / 2));
      }
      levels.add(levelLine);
      tilts.add(tiltLine);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          _initializeGrid(size);
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: size,
                painter: CircleGridPainter(
                  tilts: tilts,
                  levels: levels,
                  t: _controller.value * 2 * pi + 100,
                  numberOfColumns: widget.numberOfColumns,
                  size: size,
                  d: widget.circleDiameter,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CircleGridPainter extends CustomPainter {
  final List<List<double>> tilts;
  final List<List<double>> levels;
  final double t;
  final int numberOfColumns;
  final Size size;
  final double d;

  CircleGridPainter({
    required this.tilts,
    required this.levels,
    required this.t,
    required this.numberOfColumns,
    required this.size,
    required this.d,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / numberOfColumns;
    final numberOfRows = (size.height / cellWidth).ceil();

    for (int i = 0; i < numberOfColumns; i++) {
      double x = (i + 0.5) * cellWidth;
      for (int j = 0; j < numberOfRows; j++) {
        double y = (j + 0.5) * cellWidth;
        double theta = (t - levels[i][j]) % (2 * pi);
        if (theta < pi) theta = pi - theta;

        canvas.drawArc(
          Rect.fromCircle(center: Offset(x, y), radius: d / 2),
          tilts[i][j] - theta,
          2 * theta,
          false,
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.fill,
        );

        canvas.drawCircle(
          Offset(x, y),
          d / 2,
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
