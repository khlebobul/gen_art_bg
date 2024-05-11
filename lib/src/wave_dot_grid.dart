import 'dart:math';
import 'package:flutter/material.dart';

class WaveDotGrid extends StatefulWidget {
  final int columns; // Number of columns in the grid
  final int rows; // Number of rows in the grid
  final int locationConstant; // Location constant for wave animation

  const WaveDotGrid({
    Key? key,
    this.columns = 15, // Default number of columns
    this.rows = 25, // Default number of rows
    this.locationConstant = 100, // Default location constant
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WaveDotGridState createState() => _WaveDotGridState();
}

class _WaveDotGridState extends State<WaveDotGrid>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initializeAnimationController();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose animation controller
    super.dispose();
  }

  // Method to initialize the animation controller
  void _initializeAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Duration of animation
    )..repeat(); // Repeat the animation
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
                  begin: 1 * pi, end: 5 * pi)), // Animation for the wave effect
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
  final int columns; // Number of columns in the grid
  final int rows; // Number of rows in the grid
  final int locationConstant; // Location constant for wave animation

  _WaveGridPainter({
    required this.waveAnimation,
    required this.columns,
    required this.rows,
    required this.locationConstant,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Dot color
      ..style = PaintingStyle.fill; // Fill style for dots

    final grid = _generateGrid(size); // Generate the grid of dots

    // Iterate through each cell in the grid
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        grid[i][j].update(waveAnimation
            .value); // Update the position of the dot based on the wave animation
        canvas.drawCircle(
          Offset(
              grid[i][j].x0 * 1.2 + grid[i][j].x,
              grid[i][j].y0 * 1.2 +
                  grid[i][j].y), // Draw the dot at the updated position
          grid[i][j].r,
          paint,
        );
      }
    }
  }

  // Method to generate the grid of dots
  List<List<DotCell>> _generateGrid(Size size) {
    return List.generate(columns, (i) {
      return List.generate(rows, (j) {
        return DotCell(
          colSize: size.width / columns,
          rowSize: size.height / rows,
          x0: size.width / columns * i,
          y0: size.height / rows * j,
          r: (size.width / columns) / 10, // Radius of each dot
          angle: (size.width / columns) * locationConstant / 100 * i +
              locationConstant * j, // Angle for positioning the dots
        );
      });
    });
  }

  @override
  bool shouldRepaint(_WaveGridPainter oldDelegate) => true;
}

class DotCell {
  final double r; // Radius of the dot
  final double angle; // Angle for positioning the dot
  final double x0; // Initial X-coordinate of the dot
  final double y0; // Initial Y-coordinate of the dot
  late double x; // Updated X-coordinate of the dot
  late double y; // Updated Y-coordinate of the dot

  DotCell({
    required double colSize,
    required double rowSize,
    required this.x0,
    required this.y0,
    required this.r,
    required this.angle,
  }) {
    x = r * cos(angle); // Calculate the initial X-coordinate based on the angle
    y = r * sin(angle); // Calculate the initial Y-coordinate based on the angle
  }

  // Method to update the position of the dot based on the wave animation
  void update(double waveAnimation) {
    x = r *
        cos(angle +
            waveAnimation); // Update the X-coordinate based on the wave animation
    y = r *
        sin(angle +
            waveAnimation); // Update the Y-coordinate based on the wave animation
  }
}
