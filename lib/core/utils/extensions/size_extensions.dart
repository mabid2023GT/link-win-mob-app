import 'package:flutter/material.dart';

extension SizeExtension on Size {
  Size modifyWidth(double change) {
    return Size(width + change, height);
  }

  Size modifyHeight(double change) {
    return Size(width, height + change);
  }

  Size modifySize(double changeWidth, double changeHeight) {
    return Size(width + changeWidth, height + changeHeight);
  }

  Size modifySizeEqually(double change) {
    return Size(width + change, height + change);
  }
}
