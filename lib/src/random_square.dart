import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class RandomSquare extends StatefulWidget {
  final int gridSize;
  final Duration updateInterval;

  const RandomSquare({
    Key? key,
    this.gridSize = 10,
    this.updateInterval = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  RandomSquareState createState() => RandomSquareState();
}

class RandomSquareState extends State<RandomSquare> {
  late List<List<bool>> grid;
  late Random random;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    random = Random();
    _initializeGrid();

    timer = Timer.periodic(widget.updateInterval, (Timer t) => _updateGrid());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _initializeGrid() {
    grid = List.generate(widget.gridSize,
        (_) => List.generate(widget.gridSize, (_) => random.nextBool()));
  }

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
        if (grid[i][j]) {
          paint.color = Colors.white;
        } else {
          paint.color = Colors.black;
        }
        final rect =
            Rect.fromLTWH(i * cellWidth, j * cellHeight, cellWidth, cellHeight);

        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
