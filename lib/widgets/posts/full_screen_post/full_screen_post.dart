import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/feed_post_type.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/widgets/posts/full_screen_post/full_screen_post_app_bar.dart';
import 'package:link_win_mob_app/widgets/post_actions_buttons.dart';
import 'package:link_win_mob_app/widgets/post_profile_details.dart';
import 'package:link_win_mob_app/widgets/posts/image_post_widgets/image_posts.dart';
import 'package:link_win_mob_app/widgets/posts/video_post_widgets/video_post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FullScreenPost extends ConsumerWidget {
  final FeedPostData feedPostData;

  FullScreenPost({
    super.key,
    required this.feedPostData,
  });

  final ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isImageContent = (feedPostData.feedPostType == FeedPostType.image ||
        feedPostData.feedPostType == FeedPostType.imageCollection);
    ScreenUtil screenUtil = ScreenUtil(context);
    Size appbarSize =
        Size(screenUtil.screenWidth, screenUtil.screenHeight * 0.075);
    Size footerSize =
        Size(screenUtil.screenWidth, screenUtil.screenHeight * 0.1);
    Size bodySize = Size(
        screenUtil.screenWidth,
        screenUtil.screenHeight -
            appbarSize.height -
            (isImageContent ? footerSize.height : 0));

    return Scaffold(
      backgroundColor: kBlack,
      appBar: FullScreenPostAppBar(
        currentIndexNotifier: currentIndexNotifier,
        totalItems: feedPostData.length,
        appbarSize: appbarSize,
      ),
      body: SizedBox(
        width: bodySize.width,
        height: bodySize.height,
        child: _bodyWrapper(bodySize, footerSize, isImageContent),
      ),
    );
  }

  Widget _bodyWrapper(Size size, Size footerSize, bool isImageContent) {
    Size actionButtonsSize = Size(size.width * 0.2, size.height * 0.65);
    Size profileDetailsSize =
        Size(size.width - actionButtonsSize.width, size.height * 0.1);
    return Stack(
      children: [
        SizedBox(
            width: size.width,
            height: size.height,
            child: _fetchRelevantWidget(footerSize)),
        Positioned(
          bottom: isImageContent ? 0 : footerSize.height,
          right: 0,
          child: _actionButtons(
            actionButtonsSize,
          ),
        ),
        Positioned(
          bottom: isImageContent ? 0 : footerSize.height,
          left: 0,
          child: _profileDetails(profileDetailsSize),
        ),
      ],
    );
  }

  Widget _fetchRelevantWidget(Size footerSize) {
    switch (feedPostData.feedPostType) {
      case FeedPostType.image:
        return SingleImagePost(
          url: feedPostData.content[0],
          feedPostData: feedPostData,
        );
      case FeedPostType.imageCollection:
        return GalleryImagePost(
          urls: feedPostData.content,
          feedPostData: feedPostData,
          currentIndexNotifier: currentIndexNotifier,
        );
      case FeedPostType.video:
        return SingleVideoPost(
          url: feedPostData.content[0],
          feedPostData: feedPostData,
          videoIndex: 0,
          footerSize: footerSize,
        );
      case FeedPostType.videoCollection:
        return VideosPost(
          urls: feedPostData.content,
          feedPostData: feedPostData,
          footerSize: footerSize,
          currentIndexNotifier: currentIndexNotifier,
        );
      default:
        return Container();
    }
  }

  Widget _actionButtons(Size actionButtonsSize) {
    return Container(
      width: actionButtonsSize.width,
      height: actionButtonsSize.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(actionButtonsSize.width * 0.3),
      ),
      child: PostActionsButtons(
        isRow: false,
        pageIndex: feedPostData.pageIndex,
        postId: feedPostData.postId,
      ),
    );
  }

  Widget _profileDetails(Size profileDetailsSize) {
    return SizedBox(
      width: profileDetailsSize.width,
      height: profileDetailsSize.height,
      child: PostProfileDetails(
        withMoreVertIcon: false,
        feedPostData: feedPostData,
      ),
    );
  }
}
