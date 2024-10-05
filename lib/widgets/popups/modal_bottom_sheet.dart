import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';

void showLoadingPopup(BuildContext context) {
  ScreenUtil screenUtil = ScreenUtil(context);
  Size size = Size(
    screenUtil.widthPercentage(80),
    screenUtil.heightPercentage(50),
  );
  double leftRightPad = screenUtil.widthPercentage(5);
  double topBottomPad = screenUtil.heightPercentage(5);
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) {
      return AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.only(
          left: leftRightPad,
          right: leftRightPad,
          top: topBottomPad,
          bottom: topBottomPad,
        ),
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(size.width * 0.1),
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}
