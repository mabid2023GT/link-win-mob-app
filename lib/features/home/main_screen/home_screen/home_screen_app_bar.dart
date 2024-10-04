import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/providers/auth/auth_provider.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';

class HomeScreenAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Monitor changes in the auth provider.
    // When the user signs out, hide the app bar icons (actions).
    final user = ref.watch(authProvider).user;

    ScreenUtil screenUtil = ScreenUtil(context);
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: kHeaderColor,
      title: _titleForAuthenticatedUser(user, screenUtil, context),
      flexibleSpace: _titleForNotAuthenticatedUser(user, screenUtil, context),
      actions: _actions(user, screenUtil),
    );
  }

  _titleForAuthenticatedUser(
      User? user, ScreenUtil screenUtil, BuildContext context) {
    return user == null
        ? null
        : Padding(
            padding: EdgeInsets.only(
              left: screenUtil.screenWidth * 0.05,
              top: screenUtil.screenHeight * 0.01,
            ),
            child: _title(context),
          );
  }

  _titleForNotAuthenticatedUser(
      User? user, ScreenUtil screenUtil, BuildContext context) {
    return user == null
        ? Padding(
            padding: EdgeInsets.only(
              top: screenUtil.screenHeight * 0.05,
            ),
            child: Center(
              child: _title(context),
            ),
          )
        : null;
  }

  Text _title(BuildContext context) {
    return Text(
      'LinkWin',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }

  _actionIconWidget({
    required ScreenUtil screenUtil,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    Size iconSize = const Size(kToolbarHeight * 0.5, kToolbarHeight * 0.5);
    return LinkWinIcon(
      iconSize: iconSize,
      splashColor: k1Gray,
      onTap: onTap,
      child: SvgPicture.asset(
        iconPath,
      ),
    );
  }

  _actions(User? user, ScreenUtil screenUtil) {
    return user == null
        ? null
        : [
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
          ];
  }
}
