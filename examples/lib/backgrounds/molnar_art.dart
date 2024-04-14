import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class MolnarArt extends StatefulWidget {
  final int rows;
  final int cols;
  final int n;
  final List<Color> colSeq;

  const MolnarArt({
    Key? key,
    this.rows = 8,
    this.cols = 8,
    this.n = 12,
    this.colSeq = const [
      Color(0xFFC4951B),
      Color(0xFF9E3C52),
      Color(0xFF1D6383),
      Color(0xFF19315B),
      Color(0xFF0D1280),
      Color(0xFFADD27D),
      Color(0xFFBD1528),
      Color(0xFF0D4D89),
      Color(0xFFAC4075),
      Color(0xFFAB933C),
      Color(0xFF7EB741),
      Color(0xFF1C2266),
    ],
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MolnarArtState createState() => _MolnarArtState();
}

class _MolnarArtState extends State<MolnarArt> {
  late List<List<int>> gridCode = [];
  late double outerLen;
  late double margin;
  late double frac;
  late double outerLayerLen;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    setup();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => shiftGridCode());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // Initialize variables and setup the grid
  void setup() {
    outerLen = 100 / widget.rows; // Set the outer length of the grid cells
    margin = outerLen * 0.02; // Set the margin for the grid cells
    outerLayerLen = outerLen - 2 * margin; // Calculate outer layer length
    frac = outerLayerLen / widget.n; // Calculate the fraction

    // Generate the binary grid code
    createGridCode();
  }

  // Generate the binary grid code
  void createGridCode() {
    for (int j = 0; j < widget.rows; j++) {
      gridCode.add([]);
      for (int i = 0; i < widget.cols; i++) {
        String num = "";
        for (int b = 0; b < widget.n; b++) {
          num += Random().nextDouble() < 0.2 ? "1" : "0";
        }
        gridCode[j].add(int.parse(num, radix: 2));
      }
    }
  }

  // Shift the grid code to create animation
  void shiftGridCode() {
    for (int j = 0; j < widget.rows; j++) {
      for (int i = 0; i < widget.cols; i++) {
        gridCode[j][i] = gridCode[j][i] >> 1;
        if (Random().nextDouble() < 0.2) gridCode[j][i] += 2048;
      }
    }
    setState(() {}); // Trigger widget rebuild after shifting grid
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300, // Adjust according to your needs
          height: 300, // Adjust according to your needs
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.cols,
            ),
            itemBuilder: (BuildContext context, int index) {
              int row = (index / widget.cols).floor();
              int col = index % widget.cols;
              return AnimatedContainer(
                duration: const Duration(seconds: 1),
                color: Colors.transparent,
                child: CustomPaint(
                  painter: GridPainter(
                    binaryCode: gridCode[row][col],
                    colSeq: widget.colSeq,
                    outerLen: outerLen,
                    margin: margin,
                    frac: frac,
                    outerLayerLen: outerLayerLen,
                  ),
                ),
              );
            },
            itemCount: widget.rows * widget.cols,
          ),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final int binaryCode;
  final List<Color> colSeq;
  final double outerLen;
  final double margin;
  final double frac;
  final double outerLayerLen;

  GridPainter({
    required this.binaryCode,
    required this.colSeq,
    required this.outerLen,
    required this.margin,
    required this.frac,
    required this.outerLayerLen,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double cx, cy;

    for (int k = 0; k < colSeq.length; k++) {
      cx = outerLen / 2;
      cy = outerLen / 2;
      double len = outerLayerLen - k * frac;
      final Paint paint = Paint()
        ..color = colSeq[k]
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      if (((binaryCode >> k) & 1) == 1) {
        canvas.drawRect(
          Rect.fromLTWH(
            cx - len / 2,
            cy - len / 2,
            len,
            len,
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
