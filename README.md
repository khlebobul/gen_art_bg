# 🎨 Gen Art Backgrounds

<div align="center">

[![LICENCE - MIT](https://img.shields.io/badge/LICENCE-MIT-F4F0D9?style=for-the-badge&logo=Licence&logoColor=F4F0D9)](https://github.com/khlebobul/gen_art_bg/blob/main/LICENSE) [![pub package](https://img.shields.io/pub/v/gen_art_bg.svg?style=for-the-badge&color=F4F0D9)](https://pub.dartlang.org/packages/gen_art_bg)

![Gen Art Backgrounds GIF](https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/header.gif)

Flutter Animated Generative Art Backgrounds collection.

</div>

## Used by
- [Knight's Graph](https://knightsgraph.vercel.app)
  - [AppStore](https://apps.apple.com/us/app/knights-graph/id6737812039)
  - [Google Play](https://play.google.com/store/apps/details?id=com.khlebobul.knights_graph)

- [Board Buddy](https://boardbuddyapp.vercel.app/)
  - [AppStore](https://apps.apple.com/ru/app/board-buddy-score-counter/id6743980638?)
  - [Google Play](https://play.google.com/store/apps/details?id=com.khlebobul.board_buddy)


## Usage

```dart
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
```

<details><summary>Examples of use with parameters</summary>

   ##### AnimatedSquares

  ```dart
  AnimatedSquares(
          squareCount: 40, 
          animationDuration: 10,
          margin: 0, 
          strokeWidth: 1.5,
          palette: [
          Color(0xFFabcd5e),
          Color(0xFF14976b),
          Color(0xFF2b67af),
          Color(0xFF62b6de),
          Color(0xFFf589a3),
          Color(0xFFef562f),
          Color(0xFFfc8405),
          Color(0xFFf9d531),
        ],
        ),
  ```

  ##### AnimatedLinesGradient

  ```dart
  AnimatedLinesGradient(
          animationDuration: 5,
        ),
  ```

  ##### AnimatedLines

  ```dart
  AnimatedLines(
          numberOfLines: 30,
          lineLength: 200, 
          lineColor: Colors.black,
          strokeWidth: 3, 
          animationDuration: 10,
        ),
  ```

  ##### GridOfLines

  ```dart
  GridOfLines(
          animationDuration: 5,
          gridSize: 10, 
          strokeWidth: 0.015,
          color: Colors.black,
        ),
  ```

  ##### MolnarArt

  ```dart
  MolnarArt(
          rows: 8,
          cols: 8,
          n: 12,
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
          width: 40,
          height: 40,
          frequency: 5,
        ),
  ```

  ##### PulsedCircleGrid

  ``` dart
  PulsedCircleGrid(
          cellSize: 36,
          marginSize: 72,
          circleDiameter: 27,
          animationDuration: Duration(seconds: 5),
          numberOfRowsColumns: 12, 
        ),
  ```

  ##### RandomNoise

  ```dart
  RandomNoise(
          duration: Duration(seconds: 10),
          dotSize: 13,
          dotSpacing: 11,
        ),
  ```

  ##### RandomSquare

  ```dart
  RandomSquare(
          gridSize: 10,
          updateInterval: Duration(seconds: 1),
        ),
  ```

  ##### SpiralWave

  ```dart
  SpiralWave(
          size: 10,
          k: 20,
        ),
  ```

  ##### WaveDotGrid

  ```dart
  WaveDotGrid(
          columns: 15,
          rows: 25, 
          locationConstant: 100,
        ),
  ```

  ##### WaveLineGrid

  ```dart
  WaveLineGrid(
          columns: 15,
          rows: 25,
          locationConstant: 100,
          animationDuration:  Duration(seconds: 5),
        ),
  ```

  ##### DynamicShapes

  ```dart
  DynamicShapes(
        colors: [Colors.blue, Colors.red, Colors.green],
        maxShapes: 150,
        minShapeSize: 0.02,
        maxShapeSize: 0.08,
        minActionPoints: 3,
        maxActionPoints: 6,
        animationSpeed: 1.5,
        backgroundColor: Colors.black,
      ),
  ```

  ##### ExpandingCircles

  ```dart
  ExpandingCircles(
        colors: [
          Colors.blue,
          Colors.red,
          Colors.green,
          // ... other colors
        ],
        numberOfMovers: 15,
        gridSize: 50,
        blockScale: 0.75,
        minSpeed: 5.0,
        maxSpeed: 20.0,
        backgroundColor: Color(0xFF050505),
      ),
  ```


  ##### BubbleField

  ```dart
  BubbleField(
        backgroundColor: Colors.black,
        circleColor: Colors.white,
        animationSpeed: 1.0,
        gridSize: 100,
      ),
  ```

  ##### WaveField
  
  ```dart
  WaveField(
        gridStep: 15,
        backgroundColor: Colors.black,
        squareColor: Colors.white,
        animationSpeed: 0.7,
      ),
 ```

   ##### AsciiCube

  ```dart
  AsciiCube(
      backgroundColor: Colors.black,
      textColor: Colors.white,
      animationSpeed: 1.0,
      scale: 1.0,
      showDots: false, // like rolling dice
      edgeChars: ['@', '#', '*', '+', '=', '&'],
      dotChar: '●',
    )
  ```

  ##### RetroGridBackground

  ```dart
  RetroGridBackground(
        config: RetroGridConfig(
          gridDarkColor: Color.fromRGBO(0, 255, 255, 0.7),
          gridLightColor: Color.fromRGBO(255, 0, 128, 0.7),
          shaderColors: [
            Color(0xFF00FFFF),
            Color(0xFFFF00FE),
            Color(0xFFFFFF00),
          ],
          gridSize: 30.0, // Size of the grid
          angle: 65, // Angle of the grid lines
          animationDuration: Duration(seconds: 1),
        ),
      )
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
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/animated_squares.gif" width="100px">
      <br />
      AnimatedSquares
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
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/expanding_circles.gif" width="100px">
      <br />
      ExpandingCircles
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
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/wave_field.gif" width="100px">
      <br />
      WaveField
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/bubble_field.gif" width="100px">
      <br />
      BubbleField
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/ascii_cube.gif" width="100px">
      <br />
      AsciiCube
    </td>
    <td align="center">
      <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/retro_grid_background.gif" width="100px">
      <br />
      RetroGridBackground
    </td>
    <td align="center"></td>
    <td align="center"></td>
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

Created by [Gleb](https://khlebobul.github.io/) | khlebobul@gmail.com

[![X](https://img.shields.io/badge/X-000?style=for-the-badge&logo=x)](https://x.com/khlebobul) [![Telegram](https://img.shields.io/badge/Telegram-000?style=for-the-badge&logo=telegram&logoColor=2CA5E0)](https://t.me/khlebobul)

Support the project:
- [Telegram Stars](https://t.me/khlebobul_dev)
- [YooMoney](https://yoomoney.ru/to/4100118234947004)

Inspired by [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)

And here are some cool articles and repos on the topic of generative art in Flutter

- [Generative Art in Flutter](https://medium.com/flutter-community/generative-art-in-flutter-9e53701f7805)
- [funvas](https://github.com/creativecreatorormaybenot/funvas)
- [Flutter-Artbook](https://github.com/ikramhasan/Flutter-Artbook)
- [Art Processing Playground](https://github.com/deam91/art-playground)
- [GenArtCanvas](https://github.com/Roaa94/gen_art_canvas)
- [flutterfx_widgets](https://github.com/flutterfx/flutterfx_widgets)

#### p5.js creators
- [Patt Vira](https://www.pattvira.com)
- [mattdesl](https://p5-demos.glitch.me)

#### Processing creators
- [Roni Kaufman](https://openprocessing.org/user/184331?view=sketches&o=48)
- [Okazz](https://openprocessing.org/user/128718?view=sketches&o=588)
- [bcarrca](https://openprocessing.org/user/307670?view=sketches&o=48)


If you know of any other resources on this topic, be sure to let me know
