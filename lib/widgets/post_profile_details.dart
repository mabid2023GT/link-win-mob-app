import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_data.dart';
import 'package:link_win_mob_app/core/utils/extensions/datetime_extensions.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';

class PostProfileDetails extends StatelessWidget {
  final bool withMoreVertIcon;
  final VoidCallback onTap;
  final FeedPostData feedPostData;
  const PostProfileDetails({
    super.key,
    required this.withMoreVertIcon,
    required this.feedPostData,
    VoidCallback? onVertIconTap,
  }) : onTap = onVertIconTap ?? _defaultOnTap;

  // Default callback function
  static void _defaultOnTap() {}

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);
    return withMoreVertIcon
        ? _postHeader(screenUtil, context)
        : _postHeader(
            screenUtil,
            context,
            withMoreVertIcon: false,
          );
  }

  _postHeader(
    ScreenUtil screenUtil,
    BuildContext context, {
    bool withMoreVertIcon = true,
  }) {
    double borderRad = screenUtil.screenWidth * 0.04;
    return Container(
      decoration: BoxDecoration(
        color: kBlack.withOpacity(0.2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRad),
          topRight: Radius.circular(borderRad),
        ),
      ),
      child: AutoResponsivePercentageLayout(
        screenUtil: screenUtil,
        isRow: true,
        percentages: withMoreVertIcon ? const [2, 75, 11, 10, 2] : [2, 75, 23],
        children: [
          const SizedBox(),
          _headerDetails(context),
          const SizedBox(),
          if (withMoreVertIcon) ...[_headerMoreVert(context), const SizedBox()],
        ],
      ),
    );
  }

  _headerDetails(BuildContext context) {
    return LayoutChildBuilder(child: (minSize, maxSize) {
      Size imageSize = Size(maxSize.width * 0.25, maxSize.height);
      double space = maxSize.width * 0.05;
      Size detailsSize =
          Size(maxSize.width - imageSize.width - space, maxSize.height);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _headerDetailsImage(imageSize),
          SizedBox(
            width: space,
          ),
          Container(
            alignment: AlignmentDirectional.centerStart,
            width: detailsSize.width,
            height: detailsSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feedPostData.feedPostProfileDetails.profileName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: kWhite,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  feedPostData.postedAt.timeAgo(),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: kWhite,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  _headerDetailsImage(Size size) {
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
          feedPostData.feedPostProfileDetails.profileImgUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  _headerMoreVert(BuildContext context) {
    return LayoutChildBuilder(
      child: (minSize, maxSize) => LinkWinIcon(
        iconSize: Size(maxSize.height * 0.75, maxSize.height * 0.75),
        splashColor: kSelectedTabColor,
        iconData: Icons.more_vert,
        iconSizeRatio: 0.8,
        iconColor: kWhite,
        onTap: onTap,
      ),
    );
  }
}
