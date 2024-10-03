import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_data.dart';
import 'package:link_win_mob_app/widgets/posts/image_post_widgets/gallery_content_viewer.dart';
import 'package:photo_view/photo_view.dart';

class SingleImagePost extends StatelessWidget {
  final String url;
  final FeedPostData feedPostData;

  const SingleImagePost({
    super.key,
    required this.url,
    required this.feedPostData,
  });

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(
        url,
      ),
    );
  }
}

class GalleryImagePost extends StatelessWidget {
  final FeedPostData feedPostData;
  final List<String> urls;
  final ValueNotifier<int> currentIndexNotifier;

  const GalleryImagePost({
    super.key,
    required this.feedPostData,
    required this.urls,
    required this.currentIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GalleryContentViewer(
        contentBorderRadius: const BorderRadius.all(Radius.zero),
        feedPostData: feedPostData,
        bottomPosRatio: 0.15,
        indecatorWidthRatio: 0.4,
        currentIndexNotifier: currentIndexNotifier,
      ),
    );
  }
}
