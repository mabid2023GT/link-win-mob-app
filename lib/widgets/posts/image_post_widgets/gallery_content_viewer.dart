import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/feed_post_data.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/indecators/circle_indecator.dart';
import 'package:link_win_mob_app/widgets/posts/full_screen_post/full_screen_post.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryContentViewer extends StatefulWidget {
  final BorderRadius contentBorderRadius;
  final double bottomPosRatio;
  final double indecatorWidthRatio;
  final double indecatorHeightRatio;
  final int largeGalleryThreshold;
  final FeedPostData feedPostData;
  final ValueNotifier<int>? currentIndexNotifier;

  const GalleryContentViewer({
    super.key,
    required this.contentBorderRadius,
    required this.feedPostData,
    this.currentIndexNotifier,
    this.bottomPosRatio = 0.05,
    this.indecatorWidthRatio = 0.5,
    this.indecatorHeightRatio = 0.075,
    this.largeGalleryThreshold = 5,
  });

  @override
  State<GalleryContentViewer> createState() => _GalleryContentViewerState();
}

class _GalleryContentViewerState extends State<GalleryContentViewer> {
  late PageController _controller;
  int _currentPage = 0;
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(
      () {
        final newPage = _controller.page?.round() ?? 0;
        if (newPage != _currentPage) {
          setState(() {
            _currentPage = newPage;
            _currentPageNotifier.value = _currentPage;
            if (widget.currentIndexNotifier != null) {
              widget.currentIndexNotifier!.value = _currentPage;
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        double bottomPos = maxSize.height * widget.bottomPosRatio;
        Size indicatorSize = Size(
          maxSize.width * widget.indecatorWidthRatio,
          maxSize.height * widget.indecatorHeightRatio,
        );
        double leftRightPos = (maxSize.width - indicatorSize.width) * 0.5;
        return widget.currentIndexNotifier != null
            ? _buildGalleryContentViewer(
                context, maxSize, widget.contentBorderRadius)
            : Stack(
                children: [
                  _buildGalleryContentViewer(
                      context, maxSize, widget.contentBorderRadius),
                  Positioned(
                    bottom: bottomPos,
                    left: leftRightPos,
                    right: leftRightPos,
                    child: CircleIndicator(
                      currentPageNotifier: _currentPageNotifier,
                      indicatorLength: widget.feedPostData.length,
                      indicatorSize: indicatorSize,
                    ),
                  ),
                ],
              );
      },
    );
  }

  _openFullScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenPost(
          feedPostData: widget.feedPostData,
        ),
      ),
    );
  }

  _buildGalleryContentViewer(
      BuildContext context, Size maxSize, BorderRadius contentBorderRadius) {
    return GestureDetector(
      onTap: _openFullScreen,
      child: ClipRRect(
        borderRadius: contentBorderRadius,
        child: PhotoViewGallery.builder(
          itemCount: widget.feedPostData.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                widget.feedPostData.content[index],
              ),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
            color: kBlack,
          ),
          pageController: _controller,
        ),
      ),
    );
  }
}
