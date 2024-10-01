import 'dart:math';

import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';

class CircleIndicator extends StatelessWidget {
  final ValueNotifier currentPageNotifier;
  final int indicatorLength;
  final Size indicatorSize;
  const CircleIndicator({
    super.key,
    required this.currentPageNotifier,
    required this.indicatorLength,
    required this.indicatorSize,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPageNotifier,
      builder: (context, value, child) {
        return _buildPageIndicator(value);
      },
    );
  }

  _buildPageIndicator(int current) {
    return Container(
      width: indicatorSize.width,
      height: indicatorSize.height,
      alignment: AlignmentDirectional.center,
      // color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          min(indicatorLength, 6),
          (index) => _buildIndicator(index, current % 6),
        ),
      ),
    );
  }

  _buildIndicator(int index, int current) {
    double originSize = indicatorSize.shortestSide * 0.4;
    double calculatedSize = _calcCircleSize(originSize, index, current);
    return Container(
      width: calculatedSize,
      height: calculatedSize,
      margin: EdgeInsets.symmetric(
        horizontal: indicatorSize.width * 0.02, // Adjusted spacing
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: current == index ? kWhite : k1Gray,
      ),
    );
  }

  double _calcCircleSize(double originSize, int index, int current) {
    if (current == index) {
      return originSize;
    } else if ((current - index).abs() < 2) {
      return originSize;
    } else if ((current - index).abs() == 2) {
      return originSize * 0.75;
    } else {
      // ((current - index).abs() >= 3
      return originSize * 0.5;
    }
  }
}
