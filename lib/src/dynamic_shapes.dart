import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class DynamicShapes extends StatefulWidget {
  final List<Color>? colors;
  final int? maxShapes;
  final double? minShapeSize;
  final double? maxShapeSize;
  final int? minActionPoints;
  final int? maxActionPoints;
  final double? animationSpeed;
  final Color backgroundColor;

  const DynamicShapes({
    super.key,
    this.colors,
    this.maxShapes = 100,
    this.minShapeSize = 0.01,
    this.maxShapeSize = 0.05,
    this.minActionPoints = 2,
    this.maxActionPoints = 5,
    this.animationSpeed = 1.0,
    this.backgroundColor = Colors.white,
  });

  @override
  DynamicShapesState createState() => DynamicShapesState();
}

class DynamicShapesState extends State<DynamicShapes>
    with TickerProviderStateMixin {
  final List<DynamicShape> shapes = [];
  late final List<Color> defaultColors = [
    const Color(0xFFf71735),
    const Color(0xFFf7d002),
    const Color(0xFF1A53C0),
    const Color(0xFF232323),
  ];

  late AnimationController _controller;
  int frameCount = 0;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    shapes.add(DynamicShape(
      colors: widget.colors ?? defaultColors,
      random: random,
      minShapeSize: widget.minShapeSize!,
      maxShapeSize: widget.maxShapeSize!,
      minActionPoints: widget.minActionPoints!,
      maxActionPoints: widget.maxActionPoints!,
      animationSpeed: widget.animationSpeed!,
    ));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )
      ..addListener(() {
        setState(() {
          frameCount++;

          int randomValue = math.max(random.nextInt(15), 1);
          if (frameCount % randomValue == 0 &&
              shapes.length < widget.maxShapes!) {
            int addNum = random.nextInt(29) + 1;
            for (int i = 0; i < addNum; i++) {
              if (shapes.length < widget.maxShapes!) {
                shapes.add(DynamicShape(
                  colors: widget.colors ?? defaultColors,
                  random: random,
                  minShapeSize: widget.minShapeSize!,
                  maxShapeSize: widget.maxShapeSize!,
                  minActionPoints: widget.minActionPoints!,
                  maxActionPoints: widget.maxActionPoints!,
                  animationSpeed: widget.animationSpeed!,
                ));
              }
            }
          }

          shapes.removeWhere((shape) => shape.isDead);

          for (var shape in shapes) {
            shape.move();
          }
        });
      })
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: widget.backgroundColor,
        child: CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: ShapesPainter(shapes: shapes),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ShapesPainter extends CustomPainter {
  final List<DynamicShape> shapes;

  ShapesPainter({required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    for (var shape in shapes) {
      shape.show(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DynamicShape {
  double x, y;
  double reductionRatio = 1;
  int shapeType;
  int animationType = 0;
  int maxActionPoints;
  int actionPoints;
  double elapsedT = 0;
  double size = 0;
  double sizeMax;
  double fromSize = 0;
  bool isDead = false;
  Color color;
  bool changeShape = true;
  double angle;
  double lineSW = 0;
  double duration = 0;
  double fromX = 0;
  double fromY = 0;
  double toX = 0;
  double toY = 0;
  double toSize = 0;
  final double animationSpeed;

  DynamicShape({
    required List<Color> colors,
    required Random random,
    required double minShapeSize,
    required double maxShapeSize,
    required int minActionPoints,
    required int maxActionPoints,
    required this.animationSpeed,
  })  : x = random.nextDouble() * 0.4 + 0.3,
        y = random.nextDouble() * 0.4 + 0.3,
        shapeType = random.nextInt(4),
        maxActionPoints =
            random.nextInt(maxActionPoints - minActionPoints + 1) +
                minActionPoints,
        actionPoints = 0,
        sizeMax =
            random.nextDouble() * (maxShapeSize - minShapeSize) + minShapeSize,
        color = colors[random.nextInt(colors.length)],
        angle = random.nextInt(2) * math.pi * 0.25 {
    actionPoints = maxActionPoints;
    init();
  }

  double easeInOutExpo(double x) {
    if (x == 0) return 0;
    if (x == 1) return 1;
    if (x < 0.5) {
      return math.pow(2, 20 * x - 10) / 2;
    }
    return (2 - math.pow(2, -20 * x + 10)) / 2;
  }

  void show(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = this.size * 0.05;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = this.size * 0.05;

    canvas.save();
    canvas.translate(x * size.width, y * size.height);

    if (animationType == 1) {
      canvas.scale(1, reductionRatio);
    } else if (animationType == 2) {
      canvas.scale(reductionRatio, 1);
    }

    switch (shapeType) {
      case 0:
        canvas.drawCircle(Offset.zero, this.size * size.width / 2, paint);
        break;
      case 1:
        canvas.drawCircle(Offset.zero, this.size * size.width / 2, strokePaint);
        break;
      case 2:
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: this.size * size.width,
            height: this.size * size.width,
          ),
          paint,
        );
        break;
      case 3:
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: this.size * size.width * 0.9,
            height: this.size * size.width * 0.9,
          ),
          strokePaint,
        );
        break;
    }
    canvas.restore();

    if (lineSW > 0) {
      final linePaint = Paint()
        ..color = color
        ..strokeWidth = lineSW * size.width;

      canvas.drawLine(
        Offset(x * size.width, y * size.height),
        Offset(fromX * size.width, fromY * size.height),
        linePaint,
      );
    }
  }

  void move() {
    if (elapsedT >= 0 && elapsedT < duration) {
      double n = easeInOutExpo(elapsedT / duration);

      if (actionPoints == maxActionPoints) {
        size = lerpDouble(0, sizeMax, n)!;
      } else if (actionPoints > 0) {
        switch (animationType) {
          case 0:
            size = lerpDouble(fromSize, toSize, n)!;
            break;
          case 1:
            x = lerpDouble(fromX, toX, n)!;
            lineSW = lerpDouble(0, size / 5, math.sin(n * math.pi))!;
            break;
          case 2:
            y = lerpDouble(fromY, toY, n)!;
            lineSW = lerpDouble(0, size / 5, math.sin(n * math.pi))!;
            break;
          case 3:
            if (changeShape) {
              shapeType = Random().nextInt(4);
              changeShape = false;
            }
            break;
        }
        reductionRatio = lerpDouble(1, 0.3, math.sin(n * math.pi))!;
      } else {
        size = lerpDouble(fromSize, 0, n)!;
      }
    }

    elapsedT++;
    if (elapsedT >= duration) {
      actionPoints--;
      init();
    }
    if (actionPoints < 0) {
      isDead = true;
    }
  }

  void init() {
    elapsedT = 0;
    fromSize = size;
    toSize = sizeMax * (Random().nextDouble() + 0.5);
    fromX = x;
    toX = fromX + (Random().nextBool() ? 1 : -1) * Random().nextInt(3) * 0.1;
    fromY = y;
    toY = fromY + (Random().nextBool() ? 1 : -1) * Random().nextInt(3) * 0.1;
    animationType = Random().nextInt(3);
    duration = math.max(Random().nextDouble() * 30 + 20, 1);
    changeShape = true;
  }
}
