import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/features/home/nav/nav_svg_icon.dart';

class HomeNav extends StatelessWidget {
  final Size size;
  final void Function(int index) changePageTo;
  final int selectedIndex;
  const HomeNav({
    super.key,
    required this.size,
    required this.changePageTo,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            size.width * 0.1,
          ),
          topRight: Radius.circular(
            size.width * 0.1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: size.height * 0.5,
            // offset: Offset(0, 4),
            color: kBlack.withOpacity(0.15),
            // color: k2MainThemeColor,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavSvgIcon(
            iconIndex: 0,
            iconPath: 'assets/icons/home.svg',
            bottomNavBarHeight: size.height,
            changePageTo: changePageTo,
            selectedIndex: selectedIndex,
          ),
          NavSvgIcon(
            iconIndex: 1,
            iconPath: 'assets/icons/construction_tools.svg',
            bottomNavBarHeight: size.height,
            changePageTo: changePageTo,
            selectedIndex: selectedIndex,
          ),
          const SizedBox(),
          NavSvgIcon(
            iconIndex: 2,
            iconPath: 'assets/icons/looking-for-job.svg',
            bottomNavBarHeight: size.height,
            changePageTo: changePageTo,
            selectedIndex: selectedIndex,
          ),
          NavSvgIcon(
            iconIndex: 3,
            iconPath: 'assets/icons/profile.svg',
            bottomNavBarHeight: size.height,
            changePageTo: changePageTo,
            selectedIndex: selectedIndex,
          ),
        ],
      ),
    );
  }
}
