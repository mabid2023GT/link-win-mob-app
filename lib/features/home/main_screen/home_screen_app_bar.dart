import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);

    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.only(
          left: screenUtil.screenWidth * 0.05,
          top: screenUtil.screenHeight * 0.01,
        ),
        child: Text(
          'LinkWin',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      actions: [
        _actionIconWidget(
          screenUtil: screenUtil,
          iconPath: 'assets/icons/message.svg',
          onTap: () {},
        ),
        SizedBox(
          width: screenUtil.screenWidth * 0.05,
        ),
        _actionIconWidget(
          screenUtil: screenUtil,
          iconPath: 'assets/icons/favorite.svg',
          onTap: () {},
        ),
        SizedBox(
          width: screenUtil.screenWidth * 0.05,
        ),
        _actionIconWidget(
          screenUtil: screenUtil,
          iconPath: 'assets/icons/notification.svg',
          onTap: () {},
        ),
        SizedBox(
          width: screenUtil.screenWidth * 0.08,
        ),
      ],
    );
  }

  _actionIconWidget({
    required ScreenUtil screenUtil,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: kSelectedTabColor,
      borderRadius: BorderRadius.circular(
        screenUtil.screenWidth,
      ),
      child: SvgPicture.asset(
        iconPath,
        width: kToolbarHeight * 0.6,
        height: kToolbarHeight * 0.6,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
