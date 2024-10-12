import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/config/constants.dart';
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
    BorderSide borderSide = const BorderSide(
      color: kSelectedTabColor,
      width: 2,
    );
    Size halfSize = Size(size.width * leftNavBackgroundWidthRatio, size.height);
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: halfSize.height,
                width: halfSize.width,
                // color: kHeaderColor,
                color: kWhite,
              ),
              Container(
                height: halfSize.height,
                width: halfSize.width,
                color: kWhite,
              ),
            ],
          ),
          _innerContainer(borderSide),
        ],
      ),
    );
  }

  Widget _innerContainer(BorderSide borderSide) {
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kWhite,
        border: Border(left: borderSide, right: borderSide, top: borderSide),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size.width * 0.1),
          topRight: Radius.circular(size.width * 0.1),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: size.height * 0.5,
            color: kBlack.withOpacity(0.15),
          ),
        ],
      ),
      child: _actionButtons(),
    );
  }

  Widget _actionButtons() {
    return Row(
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
          iconPath: 'assets/icons/service_provider.svg',
          bottomNavBarHeight: size.height,
          changePageTo: changePageTo,
          selectedIndex: selectedIndex,
        ),
        const SizedBox(),
        NavSvgIcon(
          iconIndex: 2,
          iconPath: 'assets/icons/employment_icon.svg',
          // iconPath: 'assets/icons/job_search.svg',
          // iconPath: 'assets/icons/find_job.svg',
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
    );
  }
}
