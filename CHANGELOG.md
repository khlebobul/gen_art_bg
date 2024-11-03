## 0.1.6

* Add DynamicShapes widget ispired by [Okazz](https://openprocessing.org/user/128718?view=sketches&o=588)

<img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/dynamic_shapes.gif" width="100px">

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

* Add ExpandingCircles widget ispired by [Okazz](https://openprocessing.org/user/128718?view=sketches&o=588)

<img src="https://github.com/khlebobul/gen_art_bg/raw/main/screenshots/expanding_circles.gif" width="100px">

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
