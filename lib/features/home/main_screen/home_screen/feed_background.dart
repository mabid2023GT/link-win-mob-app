import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'dart:math' as math;

import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class FeedBackground extends StatelessWidget {
  final Widget child;
  const FeedBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        double shapeWidth = maxSize.width * 1.77;
        double shapeHeight = maxSize.height * 1.4;

        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              _generateShape(
                top: -shapeHeight * 0.05,
                left: -shapeWidth * 0.7,
                width: shapeWidth,
                height: shapeHeight,
                borderRadius: shapeHeight * 0.324,
                color: k2MainThemeColor,
                isLine: false,
              ),
              _generateShape(
                top: -shapeHeight * 1.2 * 0.25,
                left: -shapeWidth * 0.74,
                width: shapeWidth * 0.74,
                height: shapeHeight * 1.2,
                borderRadius: shapeHeight * 0.324,
                color: kWhite,
                isLine: true,
              ),
              _generateShape(
                top: -shapeHeight * 1.2 * 0.25,
                left: -shapeWidth * 0.74,
                width: shapeWidth * 0.66,
                height: shapeHeight * 1.15,
                borderRadius: shapeHeight * 0.324,
                color: kWhite,
                isLine: true,
              ),
              child,
            ],
          ),
        );
      },
    );
  }

  _generateShape({
    required double top,
    required double left,
    required double width,
    required double height,
    required double borderRadius,
    required Color color,
    required bool isLine,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Transform.rotate(
        angle: -math.pi / 4,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: !isLine ? color : null,
            border: isLine
                ? Border.all(
                    width: 1.0,
                    color: color,
                  )
                : null,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
