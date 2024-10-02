import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/feed_post_type.dart';
import 'package:link_win_mob_app/widgets/posts/full_screen_post/full_screen_post.dart';
import 'package:link_win_mob_app/widgets/posts/image_post_widgets/gallery_content_viewer.dart';
import 'package:link_win_mob_app/widgets/posts/video_post_widgets/video_content_viewer.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class FeedPostBody extends StatelessWidget {
  final FeedPostData feedPostData;
  final double borderRadiusPercentage;

  const FeedPostBody({
    super.key,
    required this.borderRadiusPercentage,
    required this.feedPostData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(child: (minSize, maxSize) {
      BorderRadius contentBorderRadius = BorderRadius.only(
        topLeft: Radius.circular(
          maxSize.width * borderRadiusPercentage * 0.9,
        ),
        topRight: Radius.circular(
          maxSize.width * borderRadiusPercentage * 0.9,
        ),
      );
      return Container(
        width: maxSize.width,
        height: maxSize.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              maxSize.width * borderRadiusPercentage,
            ),
            topRight: Radius.circular(
              maxSize.width * borderRadiusPercentage,
            ),
          ),
        ),
        child: _buildContentViewer(context, maxSize, contentBorderRadius),
      );
    });
  }

  _buildContentViewer(
      BuildContext context, Size maxSize, BorderRadius contentBorderRadius) {
    switch (feedPostData.feedPostType) {
      case FeedPostType.image:
        return _buildImageContentViewer(context, maxSize, contentBorderRadius);
      case FeedPostType.imageCollection:
        return GalleryContentViewer(
          contentBorderRadius: contentBorderRadius,
          feedPostData: feedPostData,
        );
      case FeedPostType.video:
        return VideoContentViewer(
          contentBorderRadius: contentBorderRadius,
          feedPostData: feedPostData,
          url: feedPostData.content[0],
        );
      case FeedPostType.videoCollection:
        return VideosContentViewer(
          contentBorderRadius: contentBorderRadius,
          feedPostData: feedPostData,
        );
      case FeedPostType.text:
        return Container(
          color: Colors.purple,
        );
    }
  }

  _buildImageContentViewer(
      BuildContext context, Size maxSize, BorderRadius contentBorderRadius) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenPost(
              feedPostData: feedPostData,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: contentBorderRadius,
        child: Image.network(
          feedPostData.content[0],
          width: maxSize.width,
          height: maxSize.height,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
