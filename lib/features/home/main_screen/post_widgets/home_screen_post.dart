import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/home_screen_post_type.dart';
import 'package:link_win_mob_app/core/utils/extensions/size_extensions.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/post_widgets/home_screen_post_body.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/responsive_percentage_layout.dart';
import 'package:link_win_mob_app/widgets/action_button.dart';
import 'package:link_win_mob_app/widgets/post_profile_details.dart';

class HomeScreenPost extends StatelessWidget {
  final HomeScreenPostData homeScreenPostData;
  const HomeScreenPost({
    super.key,
    required this.homeScreenPostData,
  });
  final double borderRadiusPercentage = 0.05;

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);
    double bordeWidth = 2;

    return LayoutBuilderChild(
      child: (minSize, maxSize) => Container(
        width: maxSize.width,
        height: maxSize.height,
        decoration: BoxDecoration(
          border: Border.all(
            width: bordeWidth,
            color: kBlack,
          ),
          borderRadius: BorderRadius.circular(
            maxSize.width * borderRadiusPercentage,
          ),
        ),
        child: ResponsivePercentageLayout(
          size: maxSize.modifySizeEqually(
            -2 * bordeWidth,
          ),
          screenUtil: screenUtil,
          isRow: false,
          percentages: const [87, 1, 12],
          children: [
            _postBody(screenUtil, context),
            const SizedBox(),
            _postActionButtons(screenUtil, context),
          ],
        ),
      ),
    );
  }

  _postBody(
    ScreenUtil screenUtil,
    BuildContext context,
  ) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size headerSize = Size(
          maxSize.width,
          maxSize.height * 0.15,
        );
        return Stack(
          children: [
            SizedBox(
              width: maxSize.width,
              height: maxSize.height,
              child: HomeScreenPostBody(
                borderRadiusPercentage: borderRadiusPercentage,
                homeScreenPostData: homeScreenPostData,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: headerSize.width,
                height: headerSize.height,
                child: PostProfileDetails(
                  withMoreVertIcon: true,
                  homeScreenPostData: homeScreenPostData,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _postActionButtons(ScreenUtil screenUtil, BuildContext context) {
    return AutoResponsivePercentageLayout(
      screenUtil: screenUtil,
      isRow: true,
      percentages: const [5, 14, 5, 14, 5, 14, 5, 14, 5, 14, 5],
      children: [
        const SizedBox(),
        ActionButton(
          context: context,
          svgPath: 'assets/icons/recommend.svg',
          actionLabel: homeScreenPostData.fetchActionsData(
            action: HomeScreenPostActions.recommend,
          ),
          activeColor: kAmber,
          isClicked: true,
          labelColor: kBlack,
        ),
        const SizedBox(),
        ActionButton(
          context: context,
          svgPath: 'assets/icons/hands_clapping.svg',
          actionLabel: homeScreenPostData.fetchActionsData(
            action: HomeScreenPostActions.support,
          ),
          isClicked: true,
          labelColor: kBlack,
        ),
        const SizedBox(),
        ActionButton(
          context: context,
          svgPath: 'assets/icons/heart.svg',
          actionLabel: homeScreenPostData.fetchActionsData(
            action: HomeScreenPostActions.favorite,
          ),
          isClicked: true,
          activeColor: kRed,
          labelColor: kBlack,
        ),
        const SizedBox(),
        ActionButton(
          context: context,
          svgPath: 'assets/icons/like.svg',
          actionLabel: homeScreenPostData.fetchActionsData(
            action: HomeScreenPostActions.like,
          ),
          isClicked: true,
          labelColor: kBlack,
        ),
        const SizedBox(),
        ActionButton(
          context: context,
          svgPath: 'assets/icons/comment.svg',
          actionLabel: homeScreenPostData.fetchActionsData(
            action: HomeScreenPostActions.comment,
          ),
          activeColor: kAmber,
          isClicked: true,
          labelColor: kBlack,
        ),
        const SizedBox(),
      ],
    );
  }
}
