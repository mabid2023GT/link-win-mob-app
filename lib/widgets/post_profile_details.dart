import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/extensions/datetime_extensions.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class PostProfileDetails extends StatelessWidget {
  final bool withMoreVertIcon;
  final VoidCallback onTap;
  final HomeScreenPostData homeScreenPostData;
  const PostProfileDetails({
    super.key,
    required this.withMoreVertIcon,
    required this.homeScreenPostData,
    VoidCallback? onVertIconTap,
  }) : onTap = onVertIconTap ?? _defaultOnTap;

  // Default callback function
  static void _defaultOnTap() {}

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);
    return withMoreVertIcon
        ? _postHeader(screenUtil, context)
        : _postHeaderWithoutMoreVertIcon(screenUtil, context);
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
                  homeScreenPostData.homeScreenPostProfileDetails.profileName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: kWhite,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  homeScreenPostData.postedAt.timeAgo(),
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
          homeScreenPostData.homeScreenPostProfileDetails.profileImgUrl,
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
          onTap: onTap,
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

  _postHeaderWithoutMoreVertIcon(ScreenUtil screenUtil, BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _headerDetailsImage(maxSize),
          Container(
            alignment: AlignmentDirectional.centerStart,
            width: maxSize.width * 0.7,
            height: maxSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homeScreenPostData.homeScreenPostProfileDetails.profileName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: kWhite,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  homeScreenPostData.postedAt.timeAgo(),
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
}
