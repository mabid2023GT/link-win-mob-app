import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'dart:math' as math;

class NavFloatingActionButton extends StatelessWidget {
  final String iconPath;
  final ColorFilter colorFilter;
  final Size bottomNavBarSize;
  final VoidCallback onTap;
  const NavFloatingActionButton({
    super.key,
    required this.iconPath,
    required this.bottomNavBarSize,
    required this.onTap,
    this.colorFilter = const ColorFilter.mode(
      kWhite,
      BlendMode.srcIn,
    ),
  });

  @override
  Widget build(BuildContext context) {
    Size buttonSize =
        Size(bottomNavBarSize.height * 0.8, bottomNavBarSize.height * 0.8);
    return GestureDetector(
      onTap: onTap,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: buttonSize.height,
          height: buttonSize.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kBlack,
            borderRadius: BorderRadius.circular(23.0),
          ),
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: SvgPicture.asset(
              iconPath,
              width: buttonSize.width * 0.7,
              height: buttonSize.height * 0.7,
              colorFilter: const ColorFilter.mode(
                kWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
