import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_button.dart';

class LWPopupLayout extends StatelessWidget {
  final String title;
  final String message;
  final bool isMessageBelowChild;
  final Duration duration;
  final Color backgroundColor;
  final Color borderColor;
  final LWPopupLayoutButtons? leftButton;
  final LWPopupLayoutButtons? rightButton;
  final Widget Function(Size size)? child;
  const LWPopupLayout({
    super.key,
    required this.title,
    required this.message,
    required this.duration,
    required this.backgroundColor,
    required this.borderColor,
    this.leftButton,
    this.rightButton,
    this.child,
    this.isMessageBelowChild = false,
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
        double topBottomPad = maxSize.height * (child == null ? 0.15 : 0.05);
        Size size = Size(maxSize.width - 2 * leftRightPad,
            maxSize.height - 2 * topBottomPad);
        Size buttonSize = Size(
            _numOfButtons() <= 1 ? size.width * 0.6 : size.width * 0.45,
            size.height * 0.15);
        Size childSize = Size(size.width, size.height * 0.35);
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
            child: child == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _contentChildren(childSize, buttonSize),
                  )
                : SizedBox(
                    width: maxSize.width,
                    height: maxSize.height,
                    child: ListView(
                      children:
                          _contentChildrenForListView(childSize, buttonSize),
                    ),
                  ),
          ),
        );
      },
    );
  }

  List<Widget> _contentChildren(Size childSize, Size buttonSize) {
    return [
      _title(),
      if (isMessageBelowChild) ...[
        if (child != null) child!(childSize),
        _message(),
      ] else ...[
        _message(),
        if (child != null) child!(childSize),
      ],
      if (leftButton != null || rightButton != null) _actions(buttonSize),
    ];
  }

  List<Widget> _contentChildrenForListView(Size childSize, Size buttonSize) {
    return [
      Center(
        child: _title(),
      ),
      SizedBox(height: buttonSize.height * 0.5),
      if (isMessageBelowChild) ...[
        if (child != null) ...[
          child!(childSize),
          SizedBox(height: buttonSize.height * 0.5),
        ],
        _message(),
      ] else ...[
        _message(),
        if (child != null) ...[
          SizedBox(height: buttonSize.height * 0.5),
          child!(childSize)
        ],
      ],
      SizedBox(height: buttonSize.height * 0.5),
      if (leftButton != null || rightButton != null) _actions(buttonSize),
      SizedBox(height: buttonSize.height * 4),
    ];
  }

  _actions(Size buttonSize) {
    return Row(
      mainAxisAlignment: _numOfButtons() <= 1
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      children: [
        if (leftButton != null)
          LinkWinButton(
            label: leftButton!.label,
            iconData: leftButton!.iconData,
            buttonSize: buttonSize,
            onTap: leftButton!.onTap,
          ),
        if (rightButton != null)
          LinkWinButton(
            label: rightButton!.label,
            iconData: rightButton!.iconData,
            buttonSize: buttonSize,
            onTap: rightButton!.onTap,
          ),
      ],
    );
  }

  _message() {
    return Text(
      message,
      textAlign: TextAlign.center,
      // overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 18,
        fontFamily: 'Loto',
        color: k1Gray,
      ),
    );
  }

  _title() {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 22,
        fontFamily: 'Loto',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _numOfButtons() {
    int count = 0;
    if (leftButton != null) count++;
    if (rightButton != null) count++;
    return count;
  }
}

class LWPopupLayoutButtons {
  final String label;
  final IconData iconData;
  final VoidCallback onTap;

  LWPopupLayoutButtons({
    required this.label,
    required this.iconData,
    required this.onTap,
  });
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
