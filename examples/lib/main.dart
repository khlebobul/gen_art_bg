import 'package:flutter/material.dart';
import 'package:flutter_gen_art_backgrounds/backgrounds/rotating_trapezium.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: RotatingTrapezium(
        nx: 20, // number of columns
        ny: 20, // number of rows
        t: 17, // trapezium
        animationDuration: Duration(seconds: 5), // animation duration
      ),
    ),
  ));
}
