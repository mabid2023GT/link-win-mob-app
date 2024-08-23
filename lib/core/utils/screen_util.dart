import 'package:flutter/material.dart';
import 'dart:math';

class ScreenUtil {
  static final ScreenUtil _instance = ScreenUtil._internal();
  late BuildContext _context;

  factory ScreenUtil(BuildContext context) {
    _instance._context = context;
    return _instance;
  }

  ScreenUtil._internal();

  /// Returns the screen width
  double get screenWidth => MediaQuery.of(_context).size.width;

  /// Returns the screen height
  double get screenHeight => MediaQuery.of(_context).size.height;

  /// Returns the responsive size based on the percentage of the screen width
  double widthPercentage(double percentage) => screenWidth * (percentage / 100);

  /// Returns the responsive size based on the percentage of the screen height
  double heightPercentage(double percentage) =>
      screenHeight * (percentage / 100);

  /// Returns true if the screen is in landscape mode
  bool get isLandscape =>
      MediaQuery.of(_context).orientation == Orientation.landscape;

  /// Returns true if the screen is in portrait mode
  bool get isPortrait =>
      MediaQuery.of(_context).orientation == Orientation.portrait;

  /// Returns the screen's aspect ratio
  double get aspectRatio => screenWidth / screenHeight;

  /// Returns the screen diagonal size
  double get diagonal =>
      sqrt(screenWidth * screenWidth + screenHeight * screenHeight);
}
