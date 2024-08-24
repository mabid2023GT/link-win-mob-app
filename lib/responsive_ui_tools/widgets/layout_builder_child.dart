import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/responsive_ui_tools/errors/responsive_ui_error.dart';

class LayoutBuilderChild extends StatelessWidget {
  final Widget Function(Size minSize, Size maxSize) child;
  const LayoutBuilderChild({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        Size minSize = Size(constraints.minWidth, constraints.minHeight);
        Size maxSize = Size(constraints.maxWidth, constraints.maxHeight);
        validateMaxSize(screenUtil, maxSize);
        return child(minSize, maxSize);
      },
    );
  }

  void validateMaxSize(ScreenUtil screenUtil, Size maxSize) {
    if (maxSize.width <= 0 ||
        maxSize.width.isInfinite ||
        maxSize.width > screenUtil.screenWidth) {
      throw ResponsiveUIError(
        "The given width (maxSize.width) is invalid. The valid value should be greater than 0 and no more than the screen width. The screen width is ${screenUtil.screenWidth}, but maxSize.width is ${maxSize.width}.",
      );
    }
    if (maxSize.height <= 0 ||
        maxSize.height.isInfinite ||
        maxSize.height > screenUtil.screenHeight) {
      throw ResponsiveUIError(
        "The given width (maxSize.height) is invalid. The valid value should be greater than 0 and no more than the screen height. The screen height is ${screenUtil.screenHeight}, but maxSize.height is ${maxSize.height}.",
      );
    }
  }
}
