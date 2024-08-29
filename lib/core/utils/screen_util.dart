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

  /// Returns the screen size
  Size get size => Size(screenWidth, screenHeight);

  /// Returns the responsive size based on the percentage of the screen width
  double widthPercentage(double percentage) => screenWidth * (percentage / 100);

  /// Returns the responsive size based on the percentage of the screen height
  double heightPercentage(double percentage) =>
      screenHeight * (percentage / 100);

  /// Returns the responsive size based on the percentage of the parent width
  double widthFromParentPercentage(double percentage, double parentWidth) =>
      parentWidth * (percentage / 100);

  /// Returns the responsive size based on the percentage of the parent height
  double heightFromParentPercentage(double percentage, double parentheight) =>
      parentheight * (percentage / 100);

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

  /// Adjusts the given percentage based on the screen width to ensure responsive
  /// sizing across different devices.
  ///
  /// This method scales the percentage according to predefined breakpoints
  /// for large, medium, and small screens:
  ///
  /// - For large screens (width >= 1200): Scales the percentage down using a scaler factor.
  /// - For medium screens (width >= 800 and < 1200): Scales the percentage down using a different scaler factor.
  /// - For small screens (width < 800): Uses the original percentage without scaling.
  ///
  /// @param width The screen width in pixels.
  /// @param percentage The original percentage to be scaled.
  /// @return The adjusted percentage based on the screen width.
  double adjustPercentageForScreenWidth(double width, double percentage) {
    double scalerForLarge = 340 / 1200;
    double scalerForMedium = 340 / 800;

    if (width >= 1200) {
      // For large screens like big tablets or desktops
      return percentage * scalerForLarge;
    } else if (width >= 800) {
      // For medium screens like smaller tablets
      return percentage * scalerForMedium;
    } else {
      // For smaller screens like mobile screens
      return percentage;
    }
  }

  /// Adjusts the given percentage based on the screen height to ensure responsive
  /// sizing across different devices.
  ///
  /// This method scales the percentage according to predefined breakpoints
  /// for large, medium, and small screens:
  ///
  /// - For tall screens (height >= 1000): Scales the percentage down using a scaler factor.
  /// - For medium-height screens (height >= 600 and < 1000): Scales the percentage down using a different scaler factor.
  /// - For short screens (height < 600): Uses the original percentage without scaling.
  ///
  /// @param height The screen height in pixels.
  /// @param percentage The original percentage to be scaled.
  /// @return The adjusted percentage based on the screen height.
  double adjustPercentageForScreenHeight(double height, double percentage) {
    double scalerForTall = 600 / 1000;
    double scalerForMedium = 600 / 800;

    if (height >= 1000) {
      // For tall screens like large tablets or desktop monitors
      return percentage * scalerForTall;
    } else if (height >= 800) {
      // For medium-height screens like smaller tablets or large phones
      return percentage * scalerForMedium;
    } else {
      // For short screens like mobile phones
      return percentage;
    }
  }
}
