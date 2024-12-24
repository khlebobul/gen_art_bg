## 0.3.9

* Add `AsciiCube`

<img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/ascii_cube.gif" width="200px"> <img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/ascii_cube_dots.gif" width="200px">

```dart
AsciiCube(
        backgroundColor: Colors.black,
        textColor: Colors.white,
        animationSpeed: 1.0,
        scale: 1.0,
        showDots: true, // like rolling dice
        edgeChars: ['@', '#', '*', '+', '=', '&'],
        dotChar: '●',
      ),
```

## 0.2.9

* Add "Used by" section at README

## 0.2.8

* Add `WaveField` widget ispired by [bcarrca](https://openprocessing.org/user/307670?view=sketches&o=48)

<img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/wave_field.gif" width="200px">

```dart
  WaveField(
        gridStep: 15,
        backgroundColor: Colors.black,
        squareColor: Colors.white,
        animationSpeed: 0.7,
      ),
```

* Add `BubbleField` widget ispired by [bcarrca](https://openprocessing.org/user/307670?view=sketches&o=48)

<img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/bubble_field.gif" width="200px">

```dart
  BubbleField(
        backgroundColor: Colors.black,
        circleColor: Colors.white,
        animationSpeed: 1.0,
        gridSize: 100,
      ),
```

* `AnimatedSquares` now includes the ability to select colors, so `AnimatedColoredSquares` and `AnimatedBwSquares` have been replaced by
* A small code refactoring was performed

## 0.1.8

* Add Codacy (code quality) badge

## 0.1.7

* Fix CHANGELOG

## 0.1.6

* Add `DynamicShapes` widget ispired by [Okazz](https://openprocessing.org/user/128718?view=sketches&o=588)

<img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/dynamic_shapes.gif" width="200px">

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

* Add `ExpandingCircles` widget ispired by [Okazz](https://openprocessing.org/user/128718?view=sketches&o=588)

<img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/expanding_circles.gif" width="200px">

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

## 0.0.6

* Updated README.md

## 0.0.5

* All widgets are adapted to different screen sizes
* Updated demos
* Removed Rotating Trapezium and Conic Gradient

## 0.0.4

* Update README.md 
    * Correcting a typographical error
    * Remove Installing section
    * Remove Import section
    * Add badge with contacts information
    * Update website link
* Update packages

## 0.0.3

* Update README.md 
    * Fixed an error in WaveDotGrid and PulsedCircleGrid name
    * Add Medium article link

## 0.0.2

* Update README.md
* Update pubspec.yaml (add more package decsription)
* Format files
* Update dependencies

## 0.0.1

* Initial version.
