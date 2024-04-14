import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotatingTrapezium extends StatefulWidget {
  final int nx; // number of columns
  final int ny; // number of rows
  final double t; // trapezium
  final Duration animationDuration; // animation duration

  const RotatingTrapezium({
    Key? key,
    this.nx = 20,
    this.ny = 20,
    this.t = 17,
    this.animationDuration = const Duration(seconds: 5),
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RotatingTrapeziumState createState() => _RotatingTrapeziumState();
}

class _RotatingTrapeziumState extends State<RotatingTrapezium>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<List<Carre>> c;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat(reverse: true);
    c = List.generate(
      widget.nx,
      (i) => List.generate(
        widget.ny,
        (j) => Carre(
          key: UniqueKey(),
          rMin: 15,
          rMax: 25,
          aRa: 0,
          aRot: 0,
          i: 0.1,
          color1: Colors.grey[700]!,
          color2: Colors.grey[200]!,
          controller: _controller,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.nx,
            ),
            itemBuilder: (context, index) {
              final int i = index ~/ widget.ny;
              final int j = index % widget.ny;
              return c[i][j];
            },
            itemCount: widget.nx * widget.ny,
          ),
        ),
      ),
    );
  }
}

class Carre extends StatefulWidget {
  final double rMin;
  final double rMax;
  final double aRa;
  final double aRot;
  final double i;
  final Color color1;
  final Color color2;
  final AnimationController controller;

  const Carre({
    Key? key,
    required this.rMin,
    required this.rMax,
    required this.aRa,
    required this.aRot,
    required this.i,
    required this.color1,
    required this.color2,
    required this.controller,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CarreState createState() => _CarreState();
}

class _CarreState extends State<Carre> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animation = Tween<double>(begin: 0, end: math.pi * 2).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double r =
            math.sin(widget.aRa) * (widget.rMax - widget.rMin) / 2 +
                (widget.rMax + widget.rMin) / 2;
        final double aRot = widget.aRot + _animation.value;
        return CustomPaint(
          painter: CarrePainter(
            r: r,
            aRot: aRot,
            color1: widget.color1,
            color2: widget.color2,
          ),
        );
      },
    );
  }
}

class CarrePainter extends CustomPainter {
  final double r;
  final double aRot;
  final Color color1;
  final Color color2;

  CarrePainter({
    required this.r,
    required this.aRot,
    required this.color1,
    required this.color2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final Offset center = size.center(Offset.zero);
    final List<Offset> points = List.generate(
      4,
      (i) {
        final double angle = aRot + (math.pi / 4) * i;
        final double x = center.dx + math.cos(angle) * r;
        final double y = center.dy + math.sin(angle) * r;
        return Offset(x, y);
      },
    );
    final Path path = Path()
      ..moveTo(points[0].dx, points[0].dy)
      ..lineTo(points[1].dx, points[1].dy)
      ..lineTo(points[2].dx, points[2].dy)
      ..lineTo(points[3].dx, points[3].dy)
      ..close();
    paint.shader = LinearGradient(
      colors: [color1, color2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromPoints(points.first, points.last));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
