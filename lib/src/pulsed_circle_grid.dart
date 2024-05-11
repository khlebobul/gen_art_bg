import 'dart:math';
import 'package:flutter/material.dart';

class PulsedCircleGrid extends StatefulWidget {
  const PulsedCircleGrid({
    Key? key,
    this.numberOfRowsColumns = 12, // Number of rows and columns in the grid
    this.cellSize = 36, // Size of each grid cell
    this.marginSize = 72, // Margin around the grid
    this.circleDiameter = 27, // Diameter of circles
    this.animationDuration = const Duration(seconds: 5), // Animation duration
  }) : super(key: key);

  final int numberOfRowsColumns; // Number of rows and columns in the grid
  final double cellSize; // Size of each grid cell
  final double marginSize; // Margin around the grid
  final double circleDiameter; // Diameter of circles
  final Duration animationDuration; // Animation duration

  @override
  // ignore: library_private_types_in_public_api
  _PulsedCircleGridState createState() => _PulsedCircleGridState();
}

class _PulsedCircleGridState extends State<PulsedCircleGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<List<double>> tilts; // Tilts for each cell
  late List<List<double>> levels; // Levels for each cell

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();
    _initializeGrid();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Initialize the grid parameters
  void _initializeGrid() {
    final n = widget.numberOfRowsColumns;
    final s = widget.cellSize;
    final margin = widget.marginSize;

    tilts = [];
    levels = [];

    for (int i = 0; i < n; i++) {
      double x = margin + (i + 0.5) * s;
      List<double> levelLine = [];
      List<double> tiltLine = [];
      for (int j = 0; j < n; j++) {
        double y = margin + (j + 0.5) * s;
        levelLine.add(sqrt(pow(x - (margin + n * s / 2), 2) +
                pow(y - (margin + n * s / 2), 2)) /
            24);
        tiltLine.add(atan2(y - (margin + n * s / 2), x - (margin + n * s / 2)));
      }
      levels.add(levelLine);
      tilts.add(tiltLine);
    }
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.numberOfRowsColumns;
    final s = widget.cellSize;
    final margin = widget.marginSize;
    final d = widget.circleDiameter;

    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(n * s + 2 * margin, n * s + 2 * margin),
            painter: CircleGridPainter(
              tilts: tilts,
              levels: levels,
              t: _controller.value * 2 * pi +
                  100, // Animation value mapped to angle
              n: n,
              s: s,
              margin: margin,
              d: d,
            ),
          );
        },
      ),
    );
  }
}

class CircleGridPainter extends CustomPainter {
  final List<List<double>> tilts; // Tilts for each cell
  final List<List<double>> levels; // Levels for each cell
  final double t; // Angle of rotation
  final int n; // Number of rows and columns in the grid
  final double s; // Size of each grid cell
  final double margin; // Margin around the grid
  final double d; // Diameter of circles

  CircleGridPainter({
    required this.tilts,
    required this.levels,
    required this.t,
    required this.n,
    required this.s,
    required this.margin,
    required this.d,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < n; i++) {
      double x = margin + (i + 0.5) * s;
      for (int j = 0; j < n; j++) {
        double y = margin + (j + 0.5) * s;
        double theta = (t - levels[i][j]) % (2 * pi);
        if (theta < pi) theta = pi - theta;

        // Draw pulsating circles
        canvas.drawArc(
          Rect.fromCircle(center: Offset(x, y), radius: d / 2),
          tilts[i][j] - theta,
          2 * theta,
          false,
          Paint()
            ..color = Colors.black
            ..style = PaintingStyle.fill,
        );

        // Draw circles outline
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
