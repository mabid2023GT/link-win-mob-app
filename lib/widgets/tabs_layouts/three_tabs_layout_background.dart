import 'dart:math';
import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class ThreeTabsLayoutBackground extends StatelessWidget {
  final bool isTapped;
  final Widget child;
  final Size? size;
  const ThreeTabsLayoutBackground({
    super.key,
    required this.isTapped,
    required this.child,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return size != null
        ? _background(size!)
        : LayoutBuilderChild(
            child: (minSize, maxSize) => _background(maxSize),
          );
  }

  _background(Size size) {
    Radius radius = Radius.circular(
      min(size.height * 0.7, size.width * 0.5),
    );
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color:
            isTapped ? kSelectedTabColor.withOpacity(0.3) : kSelectedTabColor,
        borderRadius: BorderRadius.only(
          topLeft: radius,
          bottomRight: radius,
        ),
        border: Border.all(
          color: kBlack,
          width: 2,
        ),
      ),
      child: _backgroundChild(size),
    );
  }

  _backgroundChild(Size size) {
    return Stack(
      children: [
        Positioned(
          top: size.height * 0.13,
          left: size.width * 0.2,
          child: _circularWidget(size.width * 0.1),
        ),
        Positioned(
          top: size.height * 0.04,
          left: size.width * 0.75,
          child: _circularWidget(size.width * 0.17),
        ),
        Positioned(
          top: size.height * 0.55,
          left: size.width * 0.05,
          child: _circularWidget(size.width * 0.17),
        ),
        Positioned(
          top: size.height * 0.55,
          left: size.width * 0.7,
          child: _circularWidget(size.width * 0.1),
        ),
        _childWrapper(size),
      ],
    );
  }

  _childWrapper(Size size) {
    return Center(
      child: Container(
        width: size.width * 0.7,
        height: size.height * 0.4,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            size.width,
          ),
        ),
        child: child,
      ),
    );
  }

  _circularWidget(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: !isTapped ? kWhite.withOpacity(0.4) : kWhite,
        shape: BoxShape.circle,
        border: Border.all(
          width: !isTapped ? 1 : 2,
          color: kBlack,
        ),
      ),
    );
  }
}
