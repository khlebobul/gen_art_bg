import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Configuration class to hold customizable values for the RetroGridBackground.
class RetroGridConfig {
  /// Angle for the perspective view in degrees
  final double angle;

  /// Size of grid cells in logical pixels
  final double gridSize;

  /// Duration for grid animation
  final Duration animationDuration;

  /// Color of grid lines in dark mode
  final Color gridDarkColor;

  /// Color of grid lines in light mode
  final Color gridLightColor;

  /// Background overlay color in dark mode
  final Color overlayDarkColor;

  /// Background overlay color in light mode
  final Color overlayLightColor;

  /// Gradient colors for the shader effect applied to child widgets
  final List<Color> shaderColors;

  const RetroGridConfig({
    this.angle = 65,
    this.gridSize = 40.0,
    this.animationDuration = const Duration(seconds: 1),
    this.gridDarkColor = const Color.fromRGBO(255, 255, 255, 0.6),
    this.gridLightColor = const Color.fromRGBO(0, 0, 0, 0.6),
    this.overlayDarkColor = Colors.black,
    this.overlayLightColor = const Color.fromRGBO(255, 255, 255, 0.9),
    this.shaderColors = const [
      Color(0xFFFFD319),
      Color(0xFFFF2975),
      Color(0xFF8C1EFF),
    ],
  });
}

/// Main widget that renders a retro grid background with optional child content.
class RetroGridBackground extends StatefulWidget {
  final Widget? child;
  final RetroGridConfig config;

  const RetroGridBackground({
    Key? key,
    this.child,
    this.config = const RetroGridConfig(),
  }) : super(key: key);

  @override
  State<RetroGridBackground> createState() => _RetroGridBackgroundState();
}

class _RetroGridBackgroundState extends State<RetroGridBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gridAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.config.animationDuration,
      vsync: this,
    )..repeat();

    _gridAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _gridAnimation,
                  builder: (context, child) => Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.004)
                      ..rotateX(-30 * math.pi / 180)
                      ..scale(2.0),
                    alignment: Alignment.bottomCenter,
                    child: CustomPaint(
                      size: size,
                      painter: RetroGridPainter(
                        offset: _gridAnimation.value,
                        isDark: isDark,
                        gridSize: widget.config.gridSize,
                        gridDarkColor: widget.config.gridDarkColor,
                        gridLightColor: widget.config.gridLightColor,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.transparent,
                        isDark
                            ? widget.config.overlayDarkColor
                            : widget.config.overlayLightColor,
                      ],
                      stops: const [0.0, 0.0],
                    ),
                  ),
                ),
              ),
              if (widget.child != null)
                Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: widget.config.shaderColors,
                    ).createShader(bounds),
                    child: widget.child!,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class RetroGridPainter extends CustomPainter {
  final double offset;
  final bool isDark;
  final double gridSize;
  final Color gridDarkColor;
  final Color gridLightColor;

  RetroGridPainter({
    required this.offset,
    required this.isDark,
    required this.gridSize,
    required this.gridDarkColor,
    required this.gridLightColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? gridDarkColor : gridLightColor
      ..strokeWidth = 1.5;

    final verticalLines = (size.width / gridSize).ceil() + 1;
    final horizontalLines = (size.height / gridSize).ceil() + 1;

    // Draw vertical grid lines
    for (var i = 0; i < verticalLines; i++) {
      final x = i * gridSize;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal moving grid lines
    for (var i = 0; i < horizontalLines; i++) {
      final y = (i * gridSize) - (offset * gridSize * 2);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(RetroGridPainter oldDelegate) =>
      offset != oldDelegate.offset ||
      isDark != oldDelegate.isDark ||
      gridSize != oldDelegate.gridSize ||
      gridDarkColor != oldDelegate.gridDarkColor ||
      gridLightColor != oldDelegate.gridLightColor;
}
