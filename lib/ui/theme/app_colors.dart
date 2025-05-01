import 'package:flutter/material.dart';

abstract class AppColors {
  // Grayscale
  static const grayscale800 = Color.fromRGBO(42, 42, 42, 1.0);
  static const grayscale700 = Color.fromRGBO(105, 105, 105, 1.0);
  static const grayscale600 = Color.fromRGBO(207, 207, 207, 1.0);
  static const grayscale500 = Color.fromRGBO(235, 235, 235, 1.0);
  static const grayscale400 = Color.fromRGBO(242, 242, 242, 1.0);
  static const grayscale300 = Color.fromRGBO(245, 245, 245, 1.0);
  static const grayscale200 = Color.fromRGBO(251, 251, 251, 1.0);
  static const grayscale100 = Color.fromRGBO(255, 255, 255, 1.0);

  // Additional
  static const error = Color.fromRGBO(194, 83, 76, 1.0);
  static const success = Color.fromRGBO(57, 198, 34, 1);

  // Gradient
  LinearGradient gradientOrange = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(254, 101, 15, 1.0),
      Color.fromRGBO(255, 245, 0, 0.03),
    ],
  );

  // Card indicators
  static const orangeIndicator = Color.fromRGBO(222, 99, 82, 1.0);
  static const blueIndicator = Color.fromRGBO(71, 87, 176, 1.0);
  static const yellowIndicator = Color.fromRGBO(232, 204, 62, 1.0);

  // Effects
  static const shadow1 = Color.fromRGBO(0, 0, 0, 0.04);
  static const shadow2 = Color.fromRGBO(0, 0, 0, 0.01);
}
