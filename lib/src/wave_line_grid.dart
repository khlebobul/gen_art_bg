import 'dart:math';
import 'package:flutter/material.dart';

class WaveLineGrid extends StatefulWidget {
  final int columns;
  final int rows;
  final int locationConstant;
  final Duration animationDuration;

  const WaveLineGrid({
    super.key,
    this.columns = 15,
    this.rows = 25,
    this.locationConstant = 100,
    this.animationDuration = const Duration(seconds: 5),
  });

  @override
  WaveLineGridState createState() => WaveLineGridState();
}

class WaveLineGridState extends State<WaveLineGrid>
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
      duration: widget.animationDuration,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _WaveGridPainter(
              waveAnimation: _controller.drive(Tween(
                begin: 1 * pi,
                end: 5 * pi,
              )),
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
    final paint = Paint()..color = Colors.black;
    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);

    final grid = _generateGrid(size);

    _drawGrid(canvas, grid, linePaint, paint);
  }

  List<List<LineCell>> _generateGrid(Size size) {
    const cellSize = 20.0;
    const padding = cellSize;
    final columns = ((size.width + 2 * padding) / cellSize).ceil();
    final rows = ((size.height + 2 * padding) / cellSize).ceil();

    return List.generate(columns, (i) {
      return List.generate(rows, (j) {
        return LineCell(
          cellSize: cellSize,
          x0: cellSize * i - padding,
          y0: cellSize * j - padding,
          r: cellSize / 10,
          angle: cellSize * locationConstant / 100 * i + locationConstant * j,
        );
      });
    });
  }

  void _drawGrid(
      Canvas canvas, List<List<LineCell>> grid, Paint linePaint, Paint paint) {
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        grid[i][j].update(waveAnimation.value);
        canvas.drawCircle(
          Offset(grid[i][j].x0 + grid[i][j].x, grid[i][j].y0 + grid[i][j].y),
          grid[i][j].r,
          paint,
        );

        if (i > 0) {
          canvas.drawLine(
            Offset(grid[i][j].x0 + grid[i][j].x, grid[i][j].y0 + grid[i][j].y),
            Offset(grid[i - 1][j].x0 + grid[i - 1][j].x,
                grid[i - 1][j].y0 + grid[i - 1][j].y),
            linePaint,
          );
        }
        if (j > 0) {
          canvas.drawLine(
            Offset(grid[i][j].x0 + grid[i][j].x, grid[i][j].y0 + grid[i][j].y),
            Offset(grid[i][j - 1].x0 + grid[i][j - 1].x,
                grid[i][j - 1].y0 + grid[i][j - 1].y),
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_WaveGridPainter oldDelegate) => true;
}

class LineCell {
  final double r;
  final double angle;
  final double x0;
  final double y0;
  late double x;
  late double y;

  LineCell({
    required double cellSize,
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
