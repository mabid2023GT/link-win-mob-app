import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/config/constants.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class ThreeIconBackground extends StatelessWidget {
  final Widget child;
  final IconData firstIcon;
  final IconData secondIcon;
  final IconData thirdIcon;
  final Color darkColor;
  final Color lightColor;
  const ThreeIconBackground({
    super.key,
    required this.child,
    required this.firstIcon,
    required this.secondIcon,
    required this.thirdIcon,
    this.darkColor = kHeaderColor,
    this.lightColor = kWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: LayoutChildBuilder(
        child: (minSize, maxSize) {
          Size circularIconSize =
              Size(maxSize.width * 0.3, maxSize.height * 0.3);
          return Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: maxSize.width,
              height: maxSize.height,
              child: _backgroundChildren(child, maxSize, circularIconSize),
            ),
          );
        },
      ),
    );
  }

  _backgroundChildren(Widget child, Size maxSize, Size circularIconSize) {
    return Stack(
      children: [
        ClipPath(
          clipper: _CurveClipper(),
          child: Container(
            color: lightColor,
          ),
        ),
        _iconBuilder(maxSize, circularIconSize, 0.1, 0.5, false, 0),
        _iconBuilder(maxSize, circularIconSize, 0.4, 0.1, false, 1),
        _iconBuilder(maxSize, circularIconSize, 0.7, 0.5, true, 2),
        child,
      ],
    );
  }

  _iconBuilder(
    Size maxSize,
    Size circularIconSize,
    double widthRatio,
    double heightRatio,
    bool isDarkTheme,
    int index,
  ) {
    return Positioned(
      top: maxSize.height * widthRatio,
      left: maxSize.width * heightRatio,
      child: _circularIconContainer(
        size: circularIconSize,
        icondata: index == 0
            ? firstIcon
            : index == 1
                ? secondIcon
                : thirdIcon,
        isDarkTheme: isDarkTheme,
      ),
    );
  }

  _circularIconContainer({
    required Size size,
    required bool isDarkTheme,
    required IconData icondata,
  }) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDarkTheme ? darkColor : lightColor,
      ),
      child: Icon(
        icondata,
        color: !isDarkTheme ? darkColor : lightColor,
        size: size.shortestSide * 0.6,
      ),
    );
  }
}

class _CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * leftNavBackgroundWidthRatio, size.height);
    path.quadraticBezierTo(size.width, size.height / 3, size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
