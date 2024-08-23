import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'dart:math' as math;

class OnBoardingScreenBackground extends StatelessWidget {
  final Widget child;
  const OnBoardingScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: screenUtil.screenHeight * -0.3,
            left: screenUtil.screenHeight * -0.65,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: screenUtil.screenHeight,
                width: screenUtil.screenHeight,
                padding: const EdgeInsets.all(40.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(155.0),
                    border: Border.all(width: 1.0, color: k3AccentLines)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(152.0),
                    color: k2MainThemeColor,
                  ),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
