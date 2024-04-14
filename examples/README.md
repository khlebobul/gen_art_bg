# Usage 

## AnimatedBWSquares and AnimatedColoredSquares

```dart
AnimatedBWSquares(
        squareCount: 40, // Number of squares
        animationDuration: 10, // Duration of the animation
        margin: 0, // Margin around the canvas
        strokeWidth: 1.5, // Stroke width of the squares
      ),
```

## AnimatedLinesGradient

```dart
AnimatedLinesGradient(
        animationDuration: 5, // Duration of the animation
      ),
```

## AnimatedLines

```dart
AnimatedLines(
        numberOfLines: 30, // Number of lines
        lineLength: 200, // Length of each line
        lineColor: Colors.black, // Color of each line
        strokeWidth: 3, // Stroke width of each line
        animationDuration: 10, // Duration of the animation
      ),
```

## ConicGradient

```dart
ConicGradient(
        durationSeconds: 10, // Duration of the animation in seconds
        maxDiameter: 1.2, // Maximum diameter of the gradient
        steps: 10, // Number of steps in the gradient
      ),
```

## GridOfLines

```dart
GridOfLines(
        animationDuration: 5, // Animation duration in seconds
        gridSize: 10, // Number of lines in the grid
        strokeWidth: 0.015, // Stroke width of the lines
        color: Colors.black, // Color of the lines
      ),
```

## MolnarArt

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

## PerlinNoise

``` dart
PerlinNoise(
        width: 40, // width
        height: 40, // height
        frequency: 5, // frequency
      ),
```

## PulsedCircleGrid

``` dart
PulsedCircleGrid(
        cellSize: 36, // Size of each grid cell
        marginSize: 72, // Margin around the grid 
        circleDiameter: 27, // Diameter of circles
        animationDuration: Duration(seconds: 5), // Animation duration
        numberOfRowsColumns: 12, // Number of rows and columns in the grid
      ),
```

## RandomNoise

```dart
RandomNoise(
        duration: Duration(seconds: 10), // Duration of animation
        dotSize: 13, // Size of dots
        dotSpacing: 11, // Spacing between dots
      ),
```

## RandomSquare

```dart
RandomSquare(
        gridSize: 10, // Change this value to change the grid size
        updateInterval: Duration(seconds: 1), // Change this value to change the update interval
      ),
```

## SpiralWave

```dart
SpiralWave(
        size: 10, // Size of each circle
        k: 20, // Constant value for controlling wave effect
      ),
```

## WaveDotGrid

```dart
WaveDotGrid(
        columns: 15, // Number of columns
        rows: 25, // Number of rows
        locationConstant: 100, // Location constant
      ),
```

## WaveLineGrid

```dart
WaveLineGrid(
        columns: 15, // Number of columns in the grid
        rows: 25, // Number of rows in the grid
        locationConstant: 100, // Constant to adjust the location of the grid
        animationDuration:  Duration(seconds: 5), // Duration of the animation
      ),
```

## RotatingTrapezium

```dart
RotatingTrapezium(
        nx: 20, // number of columns
        ny: 20, // number of rows
        t: 17, // trapezium
        animationDuration: Duration(seconds: 5), // animation duration
      ),
```