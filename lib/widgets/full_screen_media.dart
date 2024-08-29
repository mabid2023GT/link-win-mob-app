import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/full_screen_media_type.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/widgets/post_actions_buttons.dart';
import 'package:link_win_mob_app/widgets/post_profile_details.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenMedia extends StatelessWidget {
  final FullScreenMediaType fullScreenMediaType;
  final List<String> urls;
  final HomeScreenPostData homeScreenPostData;

  const FullScreenMedia({
    super.key,
    required this.fullScreenMediaType,
    required this.urls,
    required this.homeScreenPostData,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);
    double shortestSide = screenUtil.size.shortestSide;
    double iconSize = shortestSide * 0.11;
    Size actionButtonsSize = Size(
      screenUtil.screenWidth * 0.25,
      screenUtil.screenHeight * 0.5,
    );

    Size profileDetailsSize = Size(
      screenUtil.screenWidth * 0.7,
      screenUtil.screenHeight * 0.08,
    );

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PhotoView(
              imageProvider: NetworkImage(
                urls[0],
              ),
            ),
            Positioned(
              top: screenUtil.screenHeight * 0.05,
              right: screenUtil.screenWidth * 0.05,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: k1Gray.withOpacity(0.75),
                  ),
                  child: Icon(
                    Icons.close,
                    size: iconSize * 0.8,
                    color: kWhite,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: screenUtil.screenHeight * 0.05,
              right: screenUtil.screenWidth * 0.025,
              child: Container(
                width: actionButtonsSize.width,
                height: actionButtonsSize.height,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(actionButtonsSize.width * 0.3),
                ),
                child: PostActionsButtons(
                  isRow: false,
                  homeScreenPostData: homeScreenPostData,
                ),
              ),
            ),
            Positioned(
              bottom: screenUtil.screenHeight * 0.05,
              left: screenUtil.screenWidth * 0.05,
              child: SizedBox(
                width: profileDetailsSize.width,
                height: profileDetailsSize.height,
                child: PostProfileDetails(
                  withMoreVertIcon: false,
                  homeScreenPostData: homeScreenPostData,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
