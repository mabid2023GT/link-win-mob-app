import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/feed_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/feed_post_type.dart';
import 'package:link_win_mob_app/providers/home/feed_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/action_button.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';

class PostActionsButtons extends ConsumerWidget {
  final bool isRow;
  final int pageIndex;
  final String postId;

  const PostActionsButtons({
    super.key,
    required this.isRow,
    required this.pageIndex,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the entire feed state from the provider
    ref.watch(feedProvider);
    // Fetching the post data directly from the provider
    final feedPostData =
        ref.watch(feedProvider.notifier).fetchPost(pageIndex, postId);

    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size iconSize = Size(maxSize.width, maxSize.height * 0.15);
        return SizedBox(
          width: maxSize.width,
          height: maxSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _actionButton(
                context: context,
                iconSize: iconSize,
                svgPath: 'assets/icons/recommend.svg',
                action: FeedPostActions.recommend,
                isClicked: false,
                activeColor: kAmber,
                ref: ref,
                feedPostData: feedPostData,
              ),
              _actionButton(
                context: context,
                iconSize: iconSize,
                svgPath: 'assets/icons/hands_clapping.svg',
                action: FeedPostActions.support,
                isClicked: false,
                activeColor: kAmber,
                ref: ref,
                feedPostData: feedPostData,
              ),
              _actionButton(
                context: context,
                iconSize: iconSize,
                svgPath: 'assets/icons/favorite.svg',
                action: FeedPostActions.favorite,
                isClicked: false,
                activeColor: kAmber,
                ref: ref,
                feedPostData: feedPostData,
              ),
              _actionButton(
                context: context,
                iconSize: iconSize,
                svgPath: 'assets/icons/like.svg',
                action: FeedPostActions.like,
                isClicked: false,
                activeColor: kAmber,
                ref: ref,
                feedPostData: feedPostData,
              ),
              _actionButton(
                context: context,
                iconSize: iconSize,
                svgPath: 'assets/icons/comment.svg',
                action: FeedPostActions.comment,
                isClicked: false,
                activeColor: kAmber,
                ref: ref,
                feedPostData: feedPostData,
              ),
              _actionButton(
                context: context,
                iconSize: iconSize,
                svgPath: 'assets/icons/more_hori.svg',
                isClicked: false,
                activeColor: kAmber,
                ref: ref,
                feedPostData: feedPostData,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _actionButton({
    required BuildContext context,
    required Size iconSize,
    required String svgPath,
    required bool isClicked,
    required Color activeColor,
    required FeedPostData? feedPostData,
    // Add ref to access provider
    required WidgetRef ref,
    FeedPostActions? action,
  }) {
    return LinkWinIcon(
      iconSize: iconSize,
      splashColor: activeColor.withOpacity(0.5),
      onTap: () => _onActionButtonTapped(ref, action, feedPostData),
      child: ActionButton(
        context: context,
        svgPath: svgPath,
        actionLabel: action != null && feedPostData != null
            ? feedPostData.fetchActionsData(
                action: action,
              )
            : null,
        activeColor: activeColor,
        inactiveColor: kWhite,
        isClicked: false,
        isFullScreenChild: true,
      ),
    );
  }

  void _onActionButtonTapped(
    WidgetRef ref,
    FeedPostActions? action,
    FeedPostData? feedPostData,
  ) {
    if (action != null && feedPostData != null) {
      // Fetch current action data (optional: based on button type)
      String currentValue = feedPostData.fetchActionsData(action: action);
      // Increment by 1
      int updatedValue = int.parse(currentValue) + 1;
      // Update action data via the provider when button is tapped
      ref.read(feedProvider.notifier).updatePostAction(
            pageIndex: feedPostData.pageIndex,
            postId: feedPostData.postId,
            action: action,
            value: '$updatedValue',
          );
    }
  }
}
