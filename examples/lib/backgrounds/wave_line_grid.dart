import 'dart:math';
import 'package:flutter/material.dart';

class WaveLineGrid extends StatefulWidget {
  final int columns; // Number of columns in the grid
  final int rows; // Number of rows in the grid
  final int locationConstant; // Constant to adjust the location of the grid
  final Duration animationDuration; // Duration of the animation

  const WaveLineGrid({
    Key? key,
    this.columns = 15,
    this.rows = 25,
    this.locationConstant = 100,
    this.animationDuration = const Duration(seconds: 5),
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WaveLineGridState createState() => _WaveLineGridState();
}

class _WaveLineGridState extends State<WaveLineGrid>
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final grid = _generateGrid(size);

    _drawGrid(canvas, grid, linePaint, paint);
  }

  List<List<Cell>> _generateGrid(Size size) {
    return List.generate(columns, (i) {
      return List.generate(rows, (j) {
        return Cell(
          colSize: size.width / columns,
          rowSize: size.height / rows,
          x0: size.width / columns * i,
          y0: size.height / rows * j,
          r: (size.width / columns) / 10,
          angle: (size.width / columns) * locationConstant / 100 * i +
              locationConstant * j,
        );
      });
    });
  }

  void _drawGrid(
      Canvas canvas, List<List<Cell>> grid, Paint linePaint, Paint paint) {
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        grid[i][j].update(waveAnimation.value);
        canvas.drawCircle(
          Offset(grid[i][j].x0 * 1.2 + grid[i][j].x,
              grid[i][j].y0 * 1.2 + grid[i][j].y),
          grid[i][j].r,
          paint,
        );

        if (i > 0) {
          canvas.drawLine(
            Offset(grid[i][j].x0 * 1.2 + grid[i][j].x,
                grid[i][j].y0 * 1.2 + grid[i][j].y),
            Offset(grid[i - 1][j].x0 * 1.2 + grid[i - 1][j].x,
                grid[i - 1][j].y0 * 1.2 + grid[i - 1][j].y),
            linePaint,
          );
        }
        if (j > 0) {
          canvas.drawLine(
            Offset(grid[i][j].x0 * 1.2 + grid[i][j].x,
                grid[i][j].y0 * 1.2 + grid[i][j].y),
            Offset(grid[i][j - 1].x0 * 1.2 + grid[i][j - 1].x,
                grid[i][j - 1].y0 * 1.2 + grid[i][j - 1].y),
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_WaveGridPainter oldDelegate) => true;
}

class Cell {
  final double r;
  final double angle;
  final double x0;
  final double y0;
  late double x;
  late double y;

  Cell({
    required double colSize,
    required double rowSize,
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
