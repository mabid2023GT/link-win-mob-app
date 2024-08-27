import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          'Socially',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: screenUtil.screenWidth * 0.05,
            top: screenUtil.screenHeight * 0.01,
          ),
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/notification.svg',
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
