import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class AuthPopup extends StatelessWidget {
  final String title;
  final String message;
  final Duration duration;
  final Color backgroundColor;
  final Color borderColor;
  const AuthPopup({
    super.key,
    this.title = 'Signing Up ...',
    this.message = 'Kindly wait a moment; we will be done soon!',
    this.duration = const Duration(milliseconds: 300),
    this.backgroundColor = const Color.fromARGB(255, 163, 249, 240),
    this.borderColor = kBlack,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);
    double leftRightPad = screenUtil.widthPercentage(10);
    double topBottomPad = screenUtil.heightPercentage(10);
    Size size = Size(
      screenUtil.screenWidth - 2 * leftRightPad,
      screenUtil.screenHeight - 2 * topBottomPad,
    );
    return SizedBox(
      width: screenUtil.screenWidth,
      height: screenUtil.screenHeight,
      child: AnimatedPadding(
        duration: duration,
        padding: EdgeInsets.only(
          left: leftRightPad,
          right: leftRightPad,
          top: topBottomPad,
          bottom: topBottomPad,
        ),
        child: _popupBody(size),
      ),
    );
  }

  _popupBody(Size size) {
    Size headerSize = Size(
      size.width,
      size.height * 0.2,
    );
    Size bodySize = Size(
      size.width,
      size.height - headerSize.height,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _header(headerSize),
        _outerContainer(
          bodySize,
          kWhite,
          true,
          _outerContainer(
            bodySize,
            backgroundColor,
            false,
            _content(),
          ),
        ),
      ],
    );
  }

  _header(Size headerSize) {
    Border border = Border.all(
      width: 1,
      color: backgroundColor,
    );
    return ClipPath(
      clipper: _OutwardCurveClipper(),
      child: Container(
        width: headerSize.width,
        height: headerSize.height,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
        ),
        child: Container(
          width: headerSize.height * 0.5,
          height: headerSize.height * 0.5,
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            color: white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            FontAwesomeIcons.link,
          ),
        ),
      ),
    );
  }

  _outerContainer(
    Size size,
    Color color,
    bool isOuter,
    Widget child,
  ) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(size.width * 0.1),
          bottomRight: Radius.circular(size.width * 0.1),
        ),
        border: Border.all(
          width: 2,
          color: isOuter ? backgroundColor : color,
        ),
      ),
      child: child,
    );
  }

  _content() {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        double leftRightPad = maxSize.width * 0.05;
        double topBottomPad = maxSize.height * 0.15;
        Size size = Size(maxSize.width - 2 * leftRightPad,
            maxSize.height - 2 * topBottomPad);
        return Padding(
          padding: EdgeInsets.only(
            left: leftRightPad,
            right: leftRightPad,
            top: topBottomPad,
            bottom: topBottomPad,
          ),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Loto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircularProgressIndicator(),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Loto',
                    color: k1Gray,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OutwardCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // Start point (left side)
    path.moveTo(0, size.height);
    // Draw a quadratic Bezier curve
    path.quadraticBezierTo(
      size.width * 0.5,
      -size.height * 0.75,
      size.width,
      size.height,
    );
    // Close the remaining sides (right side and bottom)
    path.lineTo(
        size.width, size.height); // Straight line down to the bottom right
    path.lineTo(0, size.height); // Bottom left corner to close
    // Close the path
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
