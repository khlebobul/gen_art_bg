import 'package:flutter/material.dart';
import 'package:flutter_gen_art_backgrounds/wave_line_grid.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: WaveLineGrid(
        columns: 15, // Change this value to change the number of columns
        rows: 25, // Change this value to change the number of rows
        locationConstant: 100, // Change this value to change the location
        animationDuration: Duration(seconds: 5), // Change this value to change the animation duration
      )
    ),
  ));
}
