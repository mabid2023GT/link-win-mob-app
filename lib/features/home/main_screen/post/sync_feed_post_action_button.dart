import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/feed_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/feed_post_type.dart';
import 'package:link_win_mob_app/providers/home/feed_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/action_button.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';

class SyncFeedPostActionButton extends ConsumerWidget {
  final String svgPath;
  final FeedPostActions feedPostAction;
  final Color activeColor;
  final Color labelColor;
  final int pageIndex;
  final String postId;

  const SyncFeedPostActionButton({
    super.key,
    required this.svgPath,
    required this.feedPostAction,
    required this.pageIndex,
    required this.postId,
    this.activeColor = kBlue,
    this.labelColor = kBlack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the entire feed state from the provider
    ref.watch(feedProvider);
    // Fetching the post data directly from the provider
    final feedPostData =
        ref.watch(feedProvider.notifier).fetchPost(pageIndex, postId);

    return LayoutBuilderChild(
      child: (minSize, maxSize) => LinkWinIcon(
        iconSize: maxSize,
        splashColor: activeColor.withOpacity(0.5),
        onTap: () => _onActionButtonTapped(ref, feedPostAction, feedPostData),
        child: _actionButtonWrapper(
            context: context, feedPostData: feedPostData, ref: ref),
      ),
    );
  }

  Widget _actionButtonWrapper({
    required BuildContext context,
    required FeedPostData? feedPostData,
    required WidgetRef ref,
  }) {
    FeedPostActionData? feedPostActionData;
    if (feedPostData != null) {
      feedPostActionData =
          feedPostData.fetchActionsData(action: feedPostAction);
    }
    return ActionButton(
      context: context,
      svgPath: svgPath,
      actionLabel: feedPostData == null || feedPostActionData == null
          ? ''
          : feedPostActionData.value,
      activeColor: activeColor,
      isClicked: feedPostData == null || feedPostActionData == null
          ? false
          : feedPostActionData.isClicked,
      labelColor: labelColor,
    );
  }

  void _onActionButtonTapped(
    WidgetRef ref,
    FeedPostActions action,
    FeedPostData? feedPostData,
  ) {
    if (feedPostData != null) {
      // Fetch current action data (optional: based on button type)
      FeedPostActionData? feedPostActionData =
          feedPostData.fetchActionsData(action: action);
      if (feedPostActionData != null) {
        int updatedValue = feedPostActionData.updateValue();
        // Update action data via the provider when button is tapped
        ref.read(feedProvider.notifier).updatePostAction(
              pageIndex: feedPostData.pageIndex,
              postId: feedPostData.postId,
              feedPostActionData: feedPostActionData.copyWith(
                value: updatedValue,
                isClicked: !feedPostActionData.isClicked,
              ),
            );
      }
    }
  }
}
