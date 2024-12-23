import 'package:flutter/material.dart';
import 'package:flutter_gen_art_backgrounds/wave_line_grid.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: WaveLineGrid(
        columns: 15,
        rows: 25,
        locationConstant: 100,
        animationDuration: Duration(seconds: 5),
      )
    ),
  ));
}
