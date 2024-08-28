import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen_app_bar.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen_background.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen_body.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen_header.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);

    return HomeScreenBackground(
      child: Scaffold(
        backgroundColor: transparent,
        appBar: const HomeScreenAppBar(),
        body: AutoResponsivePercentageLayout(
          screenUtil: screenUtil,
          isRow: false,
          percentages: const [1, 20, 1, 78],
          children: const [
            SizedBox(),
            HomeScreenHeader(),
            SizedBox(),
            HomeScreenBody(),
          ],
        ),
      ),
    );
  }
}
