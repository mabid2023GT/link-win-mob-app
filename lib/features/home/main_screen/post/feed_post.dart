import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/feed_post_type.dart';
import 'package:link_win_mob_app/core/utils/extensions/size_extensions.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/post/feed_post_body.dart';
import 'package:link_win_mob_app/features/home/main_screen/post/sync_feed_post_action_button.dart';
import 'package:link_win_mob_app/providers/home/feed_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/responsive_percentage_layout.dart';
import 'package:link_win_mob_app/widgets/post_profile_details.dart';

class FeedPost extends ConsumerWidget {
  final int pageIndex;
  final String postId;
  const FeedPost({
    super.key,
    required this.pageIndex,
    required this.postId,
  });
  final double borderRadiusPercentage = 0.05;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the entire feed state from the provider
    ref.watch(feedProvider);
    // Fetching the post data directly from the provider
    final feedPostData =
        ref.watch(feedProvider.notifier).fetchPost(pageIndex, postId);

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
            _postBody(screenUtil, context, feedPostData),
            const SizedBox(),
            _postActionButtons(screenUtil, context, feedPostData, ref),
          ],
        ),
      ),
    );
  }

  _postBody(
    ScreenUtil screenUtil,
    BuildContext context,
    FeedPostData? feedPostData,
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
              child: feedPostData != null
                  ? FeedPostBody(
                      borderRadiusPercentage: borderRadiusPercentage,
                      feedPostData: feedPostData,
                    )
                  : null,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: headerSize.width,
                height: headerSize.height,
                child: feedPostData != null
                    ? PostProfileDetails(
                        withMoreVertIcon: true,
                        feedPostData: feedPostData,
                      )
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }

  _postActionButtons(
    ScreenUtil screenUtil,
    BuildContext context,
    FeedPostData? feedPostData,
    WidgetRef ref,
  ) {
    return AutoResponsivePercentageLayout(
      screenUtil: screenUtil,
      isRow: true,
      percentages: const [5, 14, 5, 14, 5, 14, 5, 14, 5, 14, 5],
      children: [
        const SizedBox(),
        SyncFeedPostActionButton(
          svgPath: 'assets/icons/recommend.svg',
          feedPostAction: FeedPostActions.recommend,
          pageIndex: pageIndex,
          postId: postId,
          activeColor: kAmber,
        ),
        const SizedBox(),
        SyncFeedPostActionButton(
          svgPath: 'assets/icons/hands_clapping.svg',
          feedPostAction: FeedPostActions.support,
          pageIndex: pageIndex,
          postId: postId,
        ),
        const SizedBox(),
        SyncFeedPostActionButton(
          svgPath: 'assets/icons/heart.svg',
          feedPostAction: FeedPostActions.favorite,
          pageIndex: pageIndex,
          postId: postId,
          activeColor: kRed,
        ),
        const SizedBox(),
        SyncFeedPostActionButton(
          svgPath: 'assets/icons/like.svg',
          feedPostAction: FeedPostActions.like,
          pageIndex: pageIndex,
          postId: postId,
        ),
        const SizedBox(),
        SyncFeedPostActionButton(
          svgPath: 'assets/icons/comment.svg',
          feedPostAction: FeedPostActions.comment,
          pageIndex: pageIndex,
          postId: postId,
          activeColor: kAmber,
        ),
        const SizedBox(),
      ],
    );
  }
}
