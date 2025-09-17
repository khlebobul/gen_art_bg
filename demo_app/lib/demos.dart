import 'package:gen_art_bg/gen_art_bg.dart';

import 'demo_entry.dart';

final List<DemoEntry> demos = [
  DemoEntry(
    title: 'Pulsed Circle Grid',
    builder: (_) => const PulsedCircleGrid(
      numberOfColumns: 24,
      circleDiameter: 17,
      animationDuration: Duration(seconds: 5),
    ),
  ),
  DemoEntry(
    title: 'Bubble Field',
    builder: (_) => const BubbleField(gridSize: 50),
  ),
  DemoEntry(
    title: 'Molnar Art',
    builder: (_) => const MolnarArt(rows: 4, cols: 8),
  ),
  DemoEntry(title: 'Dynamic Shapes', builder: (_) => const DynamicShapes()),
  DemoEntry(title: 'Random Noise', builder: (_) => const RandomNoise()),
  DemoEntry(title: 'Animated Lines', builder: (_) => const AnimatedLines()),
  DemoEntry(
    title: 'Animated Lines Gradient',
    builder: (_) => const AnimatedLinesGradient(),
  ),
  DemoEntry(title: 'Animated Squares', builder: (_) => const AnimatedSquares()),
  DemoEntry(
    title: 'ASCII Cube',
    builder: (_) => const AsciiCube(scale: 0.5, showDots: false),
  ),
  DemoEntry(
    title: 'Expanding Circles',
    builder: (_) => const ExpandingCircles(),
  ),
  DemoEntry(title: 'Grid of Lines', builder: (_) => const GridOfLines(
  )),
  DemoEntry(title: 'Perlin Noise', builder: (_) => const PerlinNoise()),

  DemoEntry(title: 'Random Square', builder: (_) => const RandomSquare()),
  DemoEntry(
    title: 'Retro Grid Background',
    builder: (_) => const RetroGridBackground(),
  ),
  DemoEntry(title: 'Spiral Wave', builder: (_) => const SpiralWave()),
  DemoEntry(title: 'Wave Dot Grid', builder: (_) => const WaveDotGrid()),
  DemoEntry(title: 'Wave Field', builder: (_) => const WaveField()),
  DemoEntry(title: 'Wave Line Grid', builder: (_) => const WaveLineGrid()),
];

