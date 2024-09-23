import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/feed_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/feed_post_type.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/action_button.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';

class PostActionsButtons extends StatelessWidget {
  /// Indicates whether the layout is a row (horizontal) or a column (vertical).
  ///
  /// If `true`, the layout is treated as a row, meaning the items are laid out
  /// horizontally. If `false`, the layout is treated as a column, meaning the items
  /// are laid out vertically.
  final bool isRow;

  final FeedPostData feedPostData;

  const PostActionsButtons({
    super.key,
    required this.isRow,
    required this.feedPostData,
  });

  @override
  Widget build(BuildContext context) {
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
                onTap: () {},
              ),
              _actionButton(
                context: context,
                iconSize: iconSize,
                svgPath: 'assets/icons/hands_clapping.svg',
                action: FeedPostActions.support,
                isClicked: false,
                activeColor: kAmber,
                onTap: () {},
              ),
              _actionButton(
                context: context,
                iconSize: iconSize,
                svgPath: 'assets/icons/favorite.svg',
                action: FeedPostActions.favorite,
                isClicked: false,
                activeColor: kAmber,
                onTap: () {},
              ),
              _actionButton(
                context: context,
                iconSize: iconSize,
                svgPath: 'assets/icons/like.svg',
                action: FeedPostActions.like,
                isClicked: false,
                activeColor: kAmber,
                onTap: () {},
              ),
              _actionButton(
                context: context,
                iconSize: iconSize,
                svgPath: 'assets/icons/comment.svg',
                action: FeedPostActions.comment,
                isClicked: false,
                activeColor: kAmber,
                onTap: () {},
              ),
              _actionButton(
                context: context,
                iconSize: iconSize,
                svgPath: 'assets/icons/more_hori.svg',
                isClicked: false,
                activeColor: kAmber,
                onTap: () {},
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
    required VoidCallback onTap,
    FeedPostActions? action,
  }) {
    return LinkWinIcon(
      iconSize: iconSize,
      splashColor: activeColor.withOpacity(0.5),
      onTap: onTap,
      child: ActionButton(
        context: context,
        svgPath: svgPath,
        actionLabel: action != null
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
}
