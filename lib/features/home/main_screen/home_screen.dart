import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen_app_bar.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);

    return HomeScreenBackground(
      child: Scaffold(
        backgroundColor: transparent,
        appBar: const HomeScreenAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenUtil.screenWidth * 0.1,
                ),
                child: Text(
                  'Feed',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              SizedBox(
                height: screenUtil.screenHeight * 0.01,
              ),
              Row(
                children: [
                  Container(
                    height: 56.0,
                    width: 56.0,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 24.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: k3GradientAccent,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            offset: const Offset(0, 4),
                            color: k3Pink.withOpacity(0.52),
                          )
                        ]),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
