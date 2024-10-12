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
  MolnarArtState createState() => MolnarArtState();
}

class MolnarArtState extends State<MolnarArt> {
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

  void setup() {
    outerLen = 100 / widget.rows;
    margin = outerLen * 0.02;
    outerLayerLen = outerLen - 2 * margin;
    frac = outerLayerLen / widget.n;

    createGridCode();
  }

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

  void shiftGridCode() {
    for (int j = 0; j < widget.rows; j++) {
      for (int i = 0; i < widget.cols; i++) {
        gridCode[j][i] = gridCode[j][i] >> 1;
        if (Random().nextDouble() < 0.2) gridCode[j][i] += 2048;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double cellWidth = constraints.maxWidth / widget.cols;
          double cellHeight = constraints.maxHeight / widget.rows;
          outerLen = cellWidth < cellHeight ? cellWidth : cellHeight;
          margin = outerLen * 0.02;
          outerLayerLen = outerLen - 2 * margin;
          frac = outerLayerLen / widget.n;

          return Stack(
            children: List.generate(widget.rows * widget.cols, (index) {
              int row = (index / widget.cols).floor();
              int col = index % widget.cols;
              return Positioned(
                left: col * cellWidth,
                top: row * cellHeight,
                width: cellWidth,
                height: cellHeight,
                child: CustomPaint(
                  painter: MolnarPainter(
                    binaryCode: gridCode[row][col],
                    colSeq: widget.colSeq,
                    outerLen: outerLen,
                    margin: margin,
                    frac: frac,
                    outerLayerLen: outerLayerLen,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class MolnarPainter extends CustomPainter {
  final int binaryCode;
  final List<Color> colSeq;
  final double outerLen;
  final double margin;
  final double frac;
  final double outerLayerLen;

  MolnarPainter({
    required this.binaryCode,
    required this.colSeq,
    required this.outerLen,
    required this.margin,
    required this.frac,
    required this.outerLayerLen,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double cx = size.width / 2;
    double cy = size.height / 2;

    for (int k = 0; k < colSeq.length; k++) {
      double len = outerLayerLen - k * frac;
      final Paint paint = Paint()
        ..color = colSeq[k]
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      if (((binaryCode >> k) & 1) == 1) {
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(cx, cy),
            width: len,
            height: len,
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
