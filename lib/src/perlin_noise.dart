import 'dart:math';
import 'package:flutter/material.dart';

// Widget class for PerlinNoise
class PerlinNoise extends StatefulWidget {
  const PerlinNoise({
    Key? key,
    this.width = 40, // Default width
    this.height = 40, // Default height
    this.frequency = 5, // Default frequency
  }) : super(key: key);

  final int width;
  final int height;
  final int frequency;

  @override
  // State creation for PerlinNoise widget
  // ignore: library_private_types_in_public_api
  _PerlinNoiseState createState() => _PerlinNoiseState();
}

// State class for PerlinNoise widget
class _PerlinNoiseState extends State<PerlinNoise>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<List<double>> sizes = [];

  @override
  // Initialize state
  void initState() {
    super.initState();
    // Initializing animation controller with duration and vsync
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    // Tweaking animation for smoothness
    _animation = Tween<double>(begin: 0, end: 5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear, // Using Curves.linear for smooth animation
      ),
    )..addListener(() {
        // Update state on animation change
        setState(() {
          sizes = perlin2d(
            width: widget.width,
            height: widget.height,
            frequency: widget.frequency,
            seed: Random().nextInt(10000),
            animationValue: _animation.value,
          );
        });
      });
    // Start animation loop
    _controller.repeat();
  }

  @override
  // Building the widget
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: PerlinNoisePainter(sizes: sizes),
    );
  }

  @override
  // Dispose animation controller
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Generate Perlin noise for 2D space
  List<List<double>> perlin2d({
    required int width,
    required int height,
    required int frequency,
    required int seed,
    required double animationValue,
  }) {
    return List.generate(width * frequency, (x) {
      return List.generate(height * frequency, (y) {
        final pointX = x / frequency;
        final pointY = y / frequency;
        return _perlinAtPoint(pointX, pointY, seed, animationValue);
      });
    });
  }

  // Calculate Perlin noise at a point
  double _perlinAtPoint(
    double x,
    double y,
    int seed,
    double animationValue,
  ) {
    final cellX0 = x.floor();
    final cellX1 = cellX0 + 1;
    final cellY0 = y.floor();
    final cellY1 = cellY0 + 1;

    final corner1 = _gradientOffsetDotProduct(
      cellX0,
      cellY0,
      x,
      y,
      seed,
      animationValue,
    );
    final corner2 = _gradientOffsetDotProduct(
      cellX1,
      cellY0,
      x,
      y,
      seed,
      animationValue,
    );
    final corner3 = _gradientOffsetDotProduct(
      cellX0,
      cellY1,
      x,
      y,
      seed,
      animationValue,
    );
    final corner4 = _gradientOffsetDotProduct(
      cellX1,
      cellY1,
      x,
      y,
      seed,
      animationValue,
    );

    final wx = x - cellX0;
    final wy = y - cellY0;

    final top = _interpolate(corner1, corner2, wx);
    final bottom = _interpolate(corner3, corner4, wx);

    return _interpolate(top, bottom, wy);
  }

  // Calculate gradient offset dot product
  double _gradientOffsetDotProduct(
    int cornerX,
    int cornerY,
    double pointX,
    double pointY,
    int seed,
    double animationValue,
  ) {
    final gradient = _gradient(cornerX, cornerY, seed);

    final distanceX = pointX - cornerX;
    final distanceY = pointY - cornerY;

    return distanceX * gradient.x + distanceY * gradient.y;
  }

  // Generate gradient based on given seed
  _Vector2 _gradient(int x, int y, int seed) {
    var hash = seed;

    hash ^= x * 1619;
    hash ^= y * 31337;
    hash *= 0xF2222021;
    hash ^= hash >> 15;

    const grads = [
      _Vector2(-1, -1),
      _Vector2(1, -1),
      _Vector2(-1, 1),
      _Vector2(1, 1),
      _Vector2(0, -1),
      _Vector2(-1, 0),
      _Vector2(0, 1),
      _Vector2(1, 0),
    ];

    return grads[hash & 7];
  }

  // Interpolate between two values
  double _interpolate(double a, double b, double t) {
    return (b - a) * ((t * (t * 6.0 - 15.0) + 10.0) * t * t * t) + a;
  }
}

// Custom painter for drawing Perlin noise
class PerlinNoisePainter extends CustomPainter {
  final List<List<double>> sizes;

  PerlinNoisePainter({required this.sizes});

  @override
  // Painting the canvas
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < sizes.length; i++) {
      for (int j = 0; j < sizes[i].length; j++) {
        double r = sizes[i][j] * 255;
        double g = sizes[i][j] * 255;
        double b = sizes[i][j] * 255;
        Paint paint = Paint()
          ..color = Color.fromARGB(255, r.toInt(), g.toInt(), b.toInt());
        canvas.drawRect(Rect.fromLTWH(i * 10.0, j * 10.0, 10.0, 10.0), paint);
      }
    }
  }

  @override
  // Check if repaint is needed
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Class representing 2D vector
class _Vector2 {
  const _Vector2(this.x, this.y);

  final int x;
  final int y;
}
