import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class RandomSquare extends StatefulWidget {
  final int gridSize; // Change this value to change the grid size
  final Duration
      updateInterval; // Change this value to change the update interval

  const RandomSquare({
    Key? key,
    this.gridSize = 10,
    this.updateInterval = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RandomSquareState createState() => _RandomSquareState();
}

class _RandomSquareState extends State<RandomSquare> {
  late List<List<bool>> grid;
  late Random random;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    random = Random();
    _initializeGrid();
    // Update grid periodically
    timer = Timer.periodic(widget.updateInterval, (Timer t) => _updateGrid());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // Initialize the grid with random boolean values
  void _initializeGrid() {
    grid = List.generate(widget.gridSize,
        (_) => List.generate(widget.gridSize, (_) => random.nextBool()));
  }

  // Update the grid with new random boolean values
  void _updateGrid() {
    setState(() {
      grid = List.generate(widget.gridSize,
          (_) => List.generate(widget.gridSize, (_) => random.nextBool()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: WaveGridPainter(grid),
    );
  }
}

class WaveGridPainter extends CustomPainter {
  final List<List<bool>> grid;

  WaveGridPainter(this.grid);

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / grid.length;
    final cellHeight = size.height / grid.length;
    final paint = Paint();

    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        // Set color based on the boolean value in the grid
        if (grid[i][j]) {
          paint.color = Colors.white;
        } else {
          paint.color = Colors.black;
        }
        final rect =
            Rect.fromLTWH(i * cellWidth, j * cellHeight, cellWidth, cellHeight);
        // Draw rectangle
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
