<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A simple widget for small screen with swipe to dismiss, double tap zoom && traditional zoom.

## Features

.Show a single image in a small screen mode.
.Double tap to zoom in image.
.Nice swipe animation (like in Facebook) to dismiss full screen mode.

## Getting started

simply call the package name to start using it.

## Usage

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage() : super();

  @override
  Widget build(BuildContext context) {
    return const FacebookImageView(
        image:
        "https://th.bing.com/th/id/R.0cfe3cb86925753834d56c792931315c?rik=GA0RqPxgQyA0KA&pid=ImgRaw&r=0");
  }
}
```

## Additional information

. When using this package it will open a new screen route so it can't be used inside another view.
