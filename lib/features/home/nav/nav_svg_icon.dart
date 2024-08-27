import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_win_mob_app/core/config/colors.dart';

class NavSvgIcon extends StatelessWidget {
  final int iconIndex;
  final String iconPath;
  final double bottomNavBarHeight;
  final void Function(int index) changePageTo;
  final int selectedIndex;
  const NavSvgIcon({
    super.key,
    required this.iconIndex,
    required this.iconPath,
    required this.bottomNavBarHeight,
    required this.changePageTo,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changePageTo(iconIndex),
      child: SvgPicture.asset(
        iconPath,
        height: bottomNavBarHeight * 0.5,
        width: bottomNavBarHeight * 0.5,
        colorFilter: ColorFilter.mode(
          selectedIndex == iconIndex ? kSelectedTabColor : kBlack,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
