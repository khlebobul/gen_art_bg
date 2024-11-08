# 🎨 Gen Art Backgrounds

<div align="center">

[![pub package](https://img.shields.io/pub/v/gen_art_bg.svg)](https://pub.dartlang.org/packages/gen_art_bg) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


![Gen Art Backgrounds GIF](https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/header.gif)

Flutter Animated Generative Art Backgrounds collection.

</div>


## Usage

```dart
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
```

<details><summary>Examples of use with parameters</summary>
  
   ##### AnimatedBWSquares and AnimatedColoredSquares

  ```dart
  AnimatedBWSquares(
          squareCount: 40, // Number of squares
          animationDuration: 10, // Duration of the animation
          margin: 0, // Margin around the canvas
          strokeWidth: 1.5, // Stroke width of the squares
        ),
  ```

  ##### AnimatedLinesGradient

  ```dart
  AnimatedLinesGradient(
          animationDuration: 5, // Duration of the animation
        ),
  ```

  ##### AnimatedLines

  ```dart
  AnimatedLines(
          numberOfLines: 30, // Number of lines
          lineLength: 200, // Length of each line
          lineColor: Colors.black, // Color of each line
          strokeWidth: 3, // Stroke width of each line
          animationDuration: 10, // Duration of the animation
        ),
  ```

  ##### GridOfLines

  ```dart
  GridOfLines(
          animationDuration: 5, // Animation duration in seconds
          gridSize: 10, // Number of lines in the grid
          strokeWidth: 0.015, // Stroke width of the lines
          color: Colors.black, // Color of the lines
        ),
  ```

  ##### MolnarArt

  ```dart
  MolnarArt(
          rows: 8, // Number of rows
          cols: 8, // Number of columns
          n: 12, // Code
          colSeq: [
            Color(0xFFC4951B),
            Color(0xFF9E3C52),
            Color(0xFF1D6383),
            Color(0xFF19315B),
            Color(0xFF0D1280),
            Color(0xFFADD27D),
            Color(0xFFBD1528),
            Color(0xFF0D4D89),
            Color(0xFFAC4075),
            Color(0xFFAB933C),
            Color(0xFF7EB741),
            Color(0xFF1C2266),
          ],
        ),

  ```

  The parameter `n` in the `MolnarArt` function is responsible for the number of bits in the binary code that is generated for each grid cell. This binary code is used to define the pattern structure in each cell. More specifically, each bit in this binary code indicates whether a particular layer of the pattern should be mapped or not.
  For example, if `n` in is 12, a random 12-bit binary code is generated for each grid cell. Each bit of this code represents a different layer of the pattern. If a bit is set to 1, the corresponding pattern layer will be displayed in that cell, and if the bit is 0, the layer will not be displayed.

  ##### PerlinNoise

  ``` dart
  PerlinNoise(
          width: 40, // width
          height: 40, // height
          frequency: 5, // frequency
        ),
  ```

  ##### PulsedCircleGrid

  ``` dart
  PulsedCircleGrid(
          cellSize: 36, // Size of each grid cell
          marginSize: 72, // Margin around the grid 
          circleDiameter: 27, // Diameter of circles
          animationDuration: Duration(seconds: 5), // Animation duration
          numberOfRowsColumns: 12, // Number of rows and columns in the grid
        ),
  ```

  ##### RandomNoise

  ```dart
  RandomNoise(
          duration: Duration(seconds: 10), // Duration of animation
          dotSize: 13, // Size of dots
          dotSpacing: 11, // Spacing between dots
        ),
  ```

  ##### RandomSquare

  ```dart
  RandomSquare(
          gridSize: 10, // Change this value to change the grid size
          updateInterval: Duration(seconds: 1), // Change this value to change the update interval
        ),
  ```

  ##### SpiralWave

  ```dart
  SpiralWave(
          size: 10, // Size of each circle
          k: 20, // Constant value for controlling wave effect
        ),
  ```

  ##### WaveDotGrid

  ```dart
  WaveDotGrid(
          columns: 15, // Number of columns
          rows: 25, // Number of rows
          locationConstant: 100, // Location constant
        ),
  ```

  ##### WaveLineGrid

  ```dart
  WaveLineGrid(
          columns: 15, // Number of columns in the grid
          rows: 25, // Number of rows in the grid
          locationConstant: 100, // Constant to adjust the location of the grid
          animationDuration:  Duration(seconds: 5), // Duration of the animation
        ),
  ```
  ##### DynamicShapes

  ```dart
  DynamicShapes(
        colors: [Colors.blue, Colors.red, Colors.green],
        maxShapes: 150, // max number of shapes
        minShapeSize: 0.02, // min shape size
        maxShapeSize: 0.08, // max shape size
        minActionPoints: 3, // min number of actions
        maxActionPoints: 6, // max number of actions
        animationSpeed: 1.5, // animation speed
        backgroundColor: Colors.black, // background color
      ),
  ```

  ##### ExpandingCircles

  ```dart
  ExpandingCircles(
        // Custom list of colors
        colors: [
          Colors.blue,
          Colors.red,
          Colors.green,
          // ... other colors
        ],
        // Number of moving circles
        numberOfMovers: 15,
        // Grid size (affects number of blocks)
        gridSize: 50,
        // Block scale (0.0 - 1.0)
        blockScale: 0.75,
        // Minimum circle expansion speed
        minSpeed: 5.0,
        // Maximum circle expansion speed
        maxSpeed: 20.0,
        // Background color
        backgroundColor: Color(0xFF050505),
      ),
  ```

</details>

## Showcase

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/wave_dot_grid.gif" width="100px">
      <br />
      WaveDotGrid
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/perlin_noise.gif" width="100px">
      <br />
      PerlinNoise
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/random_square.gif" width="100px">
      <br />
      RandomSquare
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/spiral_wave.gif" width="100px">
      <br />
      SpiralWave
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/grid_of_lines.gif" width="100px">
      <br />
      GridOfLines
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/animated_colored_squares.gif" width="100px">
      <br />
      AnimatedColoredSquares
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/animated_lines.gif" width="100px">
      <br />
      AnimatedLines
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/animated_lines_gradient.gif" width="100px">
      <br />
      AnimatedLinesGradient
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/random_noise.gif" width="100px">
      <br />
      RandomNoise
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/molnar_art.gif" width="100px">
      <br />
      MolnarArt
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/animated_bw_squares.gif" width="100px">
      <br />
      AnimatedBwSquares
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/wave_line_grid.gif" width="100px">
      <br />
      WaveLineGrid
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/pulsed_circle_grid.gif" width="100px">
      <br />
      PulsedCircleGrid
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/dynamic_shapes.gif" width="100px">
      <br />
      DynamicShapes
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/expanding_circles.gif" width="100px">
      <br />
      ExpandingCircles
    </td>
    <td align="center">
      Space for a new 
    </td>
  </tr>
</table>

## Bugs/Requests

If you encounter any problems feel free to open an issue. If you feel the library is
missing a feature, please raise a ticket on Github and I'll look into it.
Pull request are also welcome.

## Note

This is my first package, I will be very grateful to you if you help me to improve it or add new works.
The artwork is trusted for the web, so for now some of it may not work well on mobile devices.

## License

MIT License

## Additional information

[Medium article link](https://medium.com/@khlebobul/adding-a-bit-of-generative-art-to-a-flutter-project-13b22dd4f274)

Created by [Gled](https://khlebobul.github.io/) (a.k.a khlebobul) | sbgleb10@gmail.com

[![X](https://img.shields.io/badge/X-000?style=for-the-badge&logo=x)](https://x.com/khlebobul) [![Telegram](https://img.shields.io/badge/Telegram-000?style=for-the-badge&logo=telegram&logoColor=2CA5E0)](https://t.me/khlebobul)

Inspired by [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)

And here are some cool articles and repos on the topic of generative art in Flutter

- [Generative Art in Flutter](https://medium.com/flutter-community/generative-art-in-flutter-9e53701f7805)
- [funvas](https://github.com/creativecreatorormaybenot/funvas)
- [Flutter-Artbook](https://github.com/ikramhasan/Flutter-Artbook)
- [Art Processing Playground](https://github.com/deam91/art-playground)
- [GenArtCanvas](https://github.com/Roaa94/gen_art_canvas)

#### p5.js creators
- [Patt Vira](https://www.pattvira.com)
- [mattdesl](https://p5-demos.glitch.me)

#### Processing creators
- [Roni Kaufman](https://openprocessing.org/user/184331?view=sketches&o=48)
- [Okazz](https://openprocessing.org/user/128718?view=sketches&o=588)


If you know of any other resources on this topic, be sure to let me know
