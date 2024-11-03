import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExpandingCircles extends StatefulWidget {
  final List<Color>? colors;
  final int? numberOfMovers;
  final int? gridSize;
  final double? blockScale;
  final double? minSpeed;
  final double? maxSpeed;
  final Color backgroundColor;

  const ExpandingCircles({
    Key? key,
    this.colors,
    this.numberOfMovers = 15,
    this.gridSize = 50,
    this.blockScale = 0.75,
    this.minSpeed = 5,
    this.maxSpeed = 20,
    this.backgroundColor = const Color(0xFF050505),
  }) : super(key: key);

  @override
  ExpandingCirclesState createState() => ExpandingCirclesState();
}

class ExpandingCirclesState extends State<ExpandingCircles>
    with TickerProviderStateMixin {
  late List<Mover> movers;
  late List<Block> blocks;
  final Random random = Random();
  late AnimationController _controller;

  late final List<Color> defaultColors = [
    const Color(0xFFf0101c),
    const Color(0xFFf05697),
    const Color(0xFF0b469b),
    const Color(0xFF32b6c3),
    const Color(0xFFf78000),
    const Color(0xFFfddf0e),
    const Color(0xFF9fe063),
    const Color(0xFF761DB0),
    const Color(0xFF00E2BA),
  ];

  @override
  void initState() {
    super.initState();
    movers = [];
    blocks = [];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )
      ..addListener(() {
        setState(() {
          updateMovers();
          replaceDead();
        });
      })
      ..repeat();
  }

  void initializeBlocks(Size size) {
    if (blocks.isEmpty) {
      double blockWidth = math.min(size.width, size.height) / widget.gridSize!;
      int horizontalBlocks = (size.width / blockWidth).ceil();
      int verticalBlocks = (size.height / blockWidth).ceil();

      for (int i = 0; i < horizontalBlocks; i++) {
        for (int j = 0; j < verticalBlocks; j++) {
          double x = i * blockWidth + blockWidth / 2;
          double y = j * blockWidth + blockWidth / 2;
          blocks.add(Block(
            x: x,
            y: y,
            width: blockWidth * widget.blockScale!,
          ));
        }
      }
    }

    if (movers.isEmpty) {
      for (int i = 0; i < widget.numberOfMovers!; i++) {
        movers.add(createMover(size));
      }
    }
  }

  Mover createMover(Size size) {
    return Mover(
      x: random.nextDouble() * size.width,
      y: random.nextDouble() * size.height,
      step: random.nextDouble() * (widget.maxSpeed! - widget.minSpeed!) +
          widget.minSpeed!,
      color: (widget.colors ?? defaultColors)[
          random.nextInt(widget.colors?.length ?? defaultColors.length)],
    );
  }

  void updateMovers() {
    for (var mover in movers) {
      mover.move();
    }
  }

  void replaceDead() {
    for (int i = movers.length - 1; i >= 0; i--) {
      if (movers[i].isDead) {
        movers.removeAt(i);
        movers.add(createMover(
            Size(context.size?.width ?? 900, context.size?.height ?? 900)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          initializeBlocks(size);
          return Container(
            width: size.width,
            height: size.height,
            color: widget.backgroundColor,
            child: CustomPaint(
              painter: CirclesPainter(
                movers: movers,
                blocks: blocks,
              ),
              size: Size.infinite,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CirclesPainter extends CustomPainter {
  final List<Mover> movers;
  final List<Block> blocks;

  CirclesPainter({
    required this.movers,
    required this.blocks,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var block in blocks) {
      double offset = 0;
      Color blockColor = Colors.white;

      for (var mover in movers) {
        double distance =
            (Offset(block.x, block.y) - Offset(mover.x, mover.y)).distance;
        if (distance < (mover.diameter / 2) + 10 &&
            distance > (mover.diameter / 2) - 10) {
          offset = block.width;
          blockColor = mover.color;
        }
      }

      final paint = Paint()
        ..color = blockColor
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(block.x, block.y - offset),
          width: block.width,
          height: block.width,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Mover {
  double x;
  double y;
  double diameter;
  bool isDead;
  final double step;
  final Color color;

  Mover({
    required this.x,
    required this.y,
    required this.step,
    required this.color,
  })  : diameter = 0,
        isDead = false;

  void move() {
    diameter += step;
    if (diameter > 2700) {
      isDead = true;
    }
  }
}

class Block {
  final double x;
  final double y;
  final double width;

  Block({
    required this.x,
    required this.y,
    required this.width,
  });
}
