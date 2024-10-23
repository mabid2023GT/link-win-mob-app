import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class CommonPopupLayout extends StatelessWidget {
  final Widget Function(Size childSize) builder;
  const CommonPopupLayout({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = ScreenUtil(context).size;
    double topBottomPad = screenSize.height * 0.2;
    double sidePad = screenSize.width * 0.1;
    Size size = Size(
        screenSize.width - 2 * sidePad, screenSize.height - 2 * topBottomPad);
    return Padding(
      padding: EdgeInsets.only(
        left: sidePad,
        right: sidePad,
        top: topBottomPad,
        bottom: topBottomPad,
      ),
      child: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          color: kBlue,
          borderRadius: BorderRadius.circular(size.width * 0.1),
          border: Border.all(
            width: 1,
            color: kBlue,
          ),
        ),
        child: Card(
          color: kWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.width * 0.1),
          ),
          elevation: 10,
          child: LayoutChildBuilder(
            child: (minSize, maxSize) => builder(maxSize),
          ),
        ),
      ),
    );
  }
}
