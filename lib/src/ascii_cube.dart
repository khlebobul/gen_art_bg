import 'package:flutter/material.dart';
import 'dart:math' as math;

class AsciiCube extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final double animationSpeed;
  final double scale;
  final bool showDots;
  final List<String> edgeChars;
  final String dotChar;

  const AsciiCube({
    super.key,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.animationSpeed = 1.0,
    this.scale = 1.0,
    this.showDots = true,
    this.edgeChars = const ['@', '#', '*', '+', '=', '&'],
    this.dotChar = '●',
  });

  @override
  AsciiCubeState createState() => AsciiCubeState();
}

class AsciiCubeState extends State<AsciiCube>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _time = 0;

  final List<Vector3> _vertices = [
    Vector3(-1, -1, -1),
    Vector3(1, -1, -1),
    Vector3(1, 1, -1),
    Vector3(-1, 1, -1),
    Vector3(-1, -1, 1),
    Vector3(1, -1, 1),
    Vector3(1, 1, 1),
    Vector3(-1, 1, 1),
  ];

  final List<List<int>> _edges = [
    [0, 1],
    [1, 2],
    [2, 3],
    [3, 0],
    [4, 5],
    [5, 6],
    [6, 7],
    [7, 4],
    [0, 4],
    [1, 5],
    [2, 6],
    [3, 7],
  ];

  final List<List<int>> _faces = [
    [0, 1, 2, 3],
    [5, 4, 7, 6],
    [4, 0, 3, 7],
    [1, 5, 6, 2],
    [4, 5, 1, 0],
    [3, 2, 6, 7],
  ];

  final List<List<Offset>> _dotPatterns = [
    [
      const Offset(0.5, 0.5),
    ],
    [
      const Offset(0.3, 0.3),
      const Offset(0.7, 0.7),
    ],
    [
      const Offset(0.3, 0.3),
      const Offset(0.5, 0.5),
      const Offset(0.7, 0.7),
    ],
    [
      const Offset(0.3, 0.3),
      const Offset(0.3, 0.7),
      const Offset(0.7, 0.3),
      const Offset(0.7, 0.7),
    ],
    [
      const Offset(0.3, 0.3),
      const Offset(0.3, 0.7),
      const Offset(0.5, 0.5),
      const Offset(0.7, 0.3),
      const Offset(0.7, 0.7),
    ],
    [
      const Offset(0.3, 0.3),
      const Offset(0.3, 0.5),
      const Offset(0.3, 0.7),
      const Offset(0.7, 0.3),
      const Offset(0.7, 0.5),
      const Offset(0.7, 0.7),
    ],
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _animate();
  }

  void _animate() {
    if (!mounted) return;
    setState(() {
      _time += 0.016 * widget.animationSpeed;
    });
    Future.delayed(const Duration(milliseconds: 16), _animate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Vector3> _rotateVertices() {
    return _vertices.map((vertex) {
      final x = vertex.x;
      final y = vertex.y * math.cos(_time) - vertex.z * math.sin(_time);
      final z = vertex.y * math.sin(_time) + vertex.z * math.cos(_time);

      final x2 = x * math.cos(_time) + z * math.sin(_time);
      final y2 = y;
      final z2 = -x * math.sin(_time) + z * math.cos(_time);

      return Vector3(x2, y2, z2);
    }).toList();
  }

  String _getAsciiChar(double intensity) {
    const chars = ' .-:=+*#%@';
    final index =
        (intensity * (chars.length - 1)).round().clamp(0, chars.length - 1);
    return chars[index];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final size = math.min(width, height);

        return CustomPaint(
          size: Size(width, height),
          painter: AsciiCubePainter(
            rotatedVertices: _rotateVertices(),
            edges: _edges,
            faces: _faces,
            dotPatterns: _dotPatterns,
            backgroundColor: widget.backgroundColor,
            textColor: widget.textColor,
            scale: widget.scale,
            getAsciiChar: _getAsciiChar,
            size: size,
            showDots: widget.showDots,
            edgeChars: widget.edgeChars,
            dotChar: widget.dotChar,
          ),
        );
      },
    );
  }
}

class AsciiCubePainter extends CustomPainter {
  final List<Vector3> rotatedVertices;
  final List<List<int>> edges;
  final List<List<int>> faces;
  final List<List<Offset>> dotPatterns;
  final Color backgroundColor;
  final Color textColor;
  final double scale;
  final String Function(double) getAsciiChar;
  final double size;
  final bool showDots;
  final List<String> edgeChars;
  final String dotChar;

  AsciiCubePainter({
    required this.rotatedVertices,
    required this.edges,
    required this.faces,
    required this.dotPatterns,
    required this.backgroundColor,
    required this.textColor,
    required this.scale,
    required this.getAsciiChar,
    required this.size,
    required this.showDots,
    required this.edgeChars,
    required this.dotChar,
  });

  @override
  // ignore: avoid_renaming_method_parameters
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(Offset.zero & canvasSize, paint);

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final scaleFactor = size * 0.2 * scale;

    final visibleFaces = faces.asMap().entries.where((entry) {
      final normal = _getFaceNormal(entry.value, rotatedVertices);
      return normal.z > 0;
    }).toList();

    for (final edge in edges) {
      final start = rotatedVertices[edge[0]];
      final end = rotatedVertices[edge[1]];

      final faceIndices = visibleFaces
          .where((face) =>
              face.value.contains(edge[0]) && face.value.contains(edge[1]))
          .map((face) => face.key)
          .toList();

      if (faceIndices.isEmpty) continue;

      final startPoint = Offset(
        canvasSize.width / 2 + start.x * scaleFactor,
        canvasSize.height / 2 + start.y * scaleFactor,
      );

      final endPoint = Offset(
        canvasSize.width / 2 + end.x * scaleFactor,
        canvasSize.height / 2 + end.y * scaleFactor,
      );

      final edgeChar = edgeChars[faceIndices.first];

      const steps = 10;
      for (var i = 0; i <= steps; i++) {
        final t = i / steps;
        final x = startPoint.dx + (endPoint.dx - startPoint.dx) * t;
        final y = startPoint.dy + (endPoint.dy - startPoint.dy) * t;

        textPainter.text = TextSpan(
          text: edgeChar,
          style: TextStyle(
            color: textColor,
            fontSize: 14 * scale,
          ),
        );

        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x - textPainter.width / 2, y - textPainter.height / 2),
        );
      }
    }

    if (showDots) {
      for (var i = 0; i < faces.length; i++) {
        final face = faces[i];
        final dots = dotPatterns[i];

        final normal = _getFaceNormal(face, rotatedVertices);

        if (normal.z > 0) {
          final points = face.map((idx) {
            final v = rotatedVertices[idx];
            return Offset(
              canvasSize.width / 2 + v.x * (size * 0.2 * scale),
              canvasSize.height / 2 + v.y * (size * 0.2 * scale),
            );
          }).toList();

          for (final dot in dots) {
            final point = _interpolatePoint(points, dot.dx, dot.dy);

            textPainter.text = TextSpan(
              text: dotChar,
              style: TextStyle(
                color: textColor,
                fontSize: 8 * scale,
              ),
            );

            textPainter.layout();
            textPainter.paint(
              canvas,
              Offset(point.dx - textPainter.width / 2,
                  point.dy - textPainter.height / 2),
            );
          }
        }
      }
    }
  }

  Vector3 _getFaceNormal(List<int> face, List<Vector3> vertices) {
    final v1 = vertices[face[1]];
    final v2 = vertices[face[0]];
    final v3 = vertices[face[2]];

    final dx1 = v2.x - v1.x;
    final dy1 = v2.y - v1.y;
    final dz1 = v2.z - v1.z;

    final dx2 = v3.x - v1.x;
    final dy2 = v3.y - v1.y;
    final dz2 = v3.z - v1.z;

    return Vector3(
      dy1 * dz2 - dz1 * dy2,
      dz1 * dx2 - dx1 * dz2,
      dx1 * dy2 - dy1 * dx2,
    );
  }

  Offset _interpolatePoint(List<Offset> points, double u, double v) {
    final p0 = points[0];
    final p1 = points[1];
    final p2 = points[2];
    final p3 = points[3];

    final x = _lerp(_lerp(p0.dx, p1.dx, u), _lerp(p3.dx, p2.dx, u), v);

    final y = _lerp(_lerp(p0.dy, p1.dy, u), _lerp(p3.dy, p2.dy, u), v);

    return Offset(x, y);
  }

  double _lerp(double a, double b, double t) {
    return a + (b - a) * t;
  }

  @override
  bool shouldRepaint(AsciiCubePainter oldDelegate) {
    return true;
  }
}

class Vector3 {
  double x;
  double y;
  double z;

  Vector3(this.x, this.y, this.z);
}
