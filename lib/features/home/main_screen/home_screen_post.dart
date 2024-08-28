import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/home_screen_post_type.dart';
import 'package:link_win_mob_app/core/utils/extensions/size_extensions.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen_post_body.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/responsive_percentage_layout.dart';

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

  _postHeader(ScreenUtil screenUtil, BuildContext context) {
    return AutoResponsivePercentageLayout(
      screenUtil: screenUtil,
      isRow: true,
      percentages: const [2, 75, 11, 10, 2],
      children: [
        const SizedBox(),
        _headerDetails(context),
        const SizedBox(),
        _headerMoreVert(context),
        const SizedBox(),
      ],
    );
  }

  _headerDetails(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _headerDetailsImage(maxSize),
          Container(
            alignment: AlignmentDirectional.centerStart,
            width: maxSize.width * 0.75,
            height: maxSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mohammad Abid',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: kWhite,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '10 h',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: kWhite,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _headerDetailsImage(Size maxSize) {
    Size size = Size(
      maxSize.width * 0.25,
      maxSize.height,
    );
    double imgSize = size.height < size.width ? size.height : size.width;
    return Container(
      width: imgSize,
      height: imgSize,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: kWhite,
            width: 1,
          )),
      child: ClipOval(
        child: Image.network(
          'https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  _headerMoreVert(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => Material(
        color: transparent,
        child: InkWell(
          onTap: () {
            // context.go('/auth');
          },
          splashColor: kSelectedTabColor,
          child: Icon(
            Icons.more_vert,
            size: maxSize.height * 0.75,
            color: kWhite,
          ),
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
                child: _postHeader(screenUtil, context),
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
        _actionButton(
          context: context,
          svgPath: 'assets/icons/message.svg',
          isClicked: false,
        ),
        const SizedBox(),
        _actionButton(
          context: context,
          svgPath: 'assets/icons/hands_clapping.svg',
          actionLabel: homeScreenPostData.fetchActionsData(
            action: HomeScreenPostActions.support,
          ),
          isClicked: true,
        ),
        const SizedBox(),
        _actionButton(
          context: context,
          svgPath: 'assets/icons/heart.svg',
          actionLabel: homeScreenPostData.fetchActionsData(
            action: HomeScreenPostActions.favorite,
          ),
          isClicked: true,
          color: kRed,
        ),
        const SizedBox(),
        _actionButton(
          context: context,
          svgPath: 'assets/icons/like.svg',
          actionLabel: homeScreenPostData.fetchActionsData(
            action: HomeScreenPostActions.like,
          ),
          isClicked: false,
        ),
        const SizedBox(),
        _actionButton(
          context: context,
          svgPath: 'assets/icons/share.svg',
          isClicked: false,
        ),
        const SizedBox(),
      ],
    );
  }

  _actionButton({
    required BuildContext context,
    required String svgPath,
    required bool isClicked,
    Color color = kBlue,
    String? actionLabel,
  }) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        double iconSizePercentage = actionLabel != null ? 0.55 : 0.65;
        double iconSize = maxSize.height * iconSizePercentage;
        return actionLabel != null
            ? Column(
                children: [
                  SvgPicture.asset(
                    svgPath,
                    width: iconSize,
                    height: iconSize,
                    colorFilter: ColorFilter.mode(
                      isClicked ? color : kBlack,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    actionLabel,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            : SvgPicture.asset(
                svgPath,
                width: iconSize,
                height: iconSize,
                colorFilter: ColorFilter.mode(
                  isClicked ? color : kBlack,
                  BlendMode.srcIn,
                ),
              );
      },
    );
  }
}
