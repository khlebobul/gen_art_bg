import 'dart:math';
import 'package:flutter/material.dart';

class WaveDotGrid extends StatefulWidget {
  final int columns;
  final int rows;
  final int locationConstant;

  const WaveDotGrid({
    Key? key,
    this.columns = 15,
    this.rows = 25,
    this.locationConstant = 100,
  }) : super(key: key);

  @override
  WaveDotGridState createState() => WaveDotGridState();
}

class WaveDotGridState extends State<WaveDotGrid>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initializeAnimationController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _WaveGridPainter(
              waveAnimation:
                  _controller.drive(Tween(begin: 1 * pi, end: 5 * pi)),
              columns: widget.columns,
              rows: widget.rows,
              locationConstant: widget.locationConstant,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _WaveGridPainter extends CustomPainter {
  final Animation<double> waveAnimation;
  final int columns;
  final int rows;
  final int locationConstant;

  _WaveGridPainter({
    required this.waveAnimation,
    required this.columns,
    required this.rows,
    required this.locationConstant,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final grid = _generateGrid(size);

    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        grid[i][j].update(waveAnimation.value);
        canvas.drawCircle(
          Offset(grid[i][j].x0 + grid[i][j].x, grid[i][j].y0 + grid[i][j].y),
          grid[i][j].r,
          paint,
        );
      }
    }
  }

  List<List<DotCell>> _generateGrid(Size size) {
    final dotSize = size.width / (columns * 10);
    return List.generate(columns, (i) {
      return List.generate(rows, (j) {
        return DotCell(
          x0: size.width / columns * (i + 0.5),
          y0: size.height / rows * (j + 0.5),
          r: dotSize,
          angle: 2 * pi * i / columns + 2 * pi * j / rows,
        );
      });
    });
  }

  @override
  bool shouldRepaint(_WaveGridPainter oldDelegate) => true;
}

class DotCell {
  final double r;
  final double angle;
  final double x0;
  final double y0;
  late double x;
  late double y;

  DotCell({
    required this.x0,
    required this.y0,
    required this.r,
    required this.angle,
  }) {
    x = r * cos(angle);
    y = r * sin(angle);
  }

  void update(double waveAnimation) {
    x = r * cos(angle + waveAnimation);
    y = r * sin(angle + waveAnimation);
  }
}
