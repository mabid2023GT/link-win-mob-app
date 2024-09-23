import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/feed_post_data.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryContentViewer extends StatefulWidget {
  final BorderRadius contentBorderRadius;
  final double bottomPosRatio;
  final double indecatorWidthRatio;
  final double indecatorHeightRatio;
  final int largeGalleryThreshold;
  final FeedPostData feedPostData;

  const GalleryContentViewer({
    super.key,
    required this.contentBorderRadius,
    required this.feedPostData,
    this.bottomPosRatio = 0.012,
    this.indecatorWidthRatio = 0.5,
    this.indecatorHeightRatio = 0.15,
    this.largeGalleryThreshold = 5,
  });

  @override
  State<GalleryContentViewer> createState() => _GalleryContentViewerState();
}

class _GalleryContentViewerState extends State<GalleryContentViewer> {
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(() {
      final newPage = _controller.page?.round() ?? 0;
      if (newPage != _currentPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });
  }

  void _jumpToPage({
    required bool isNextPage,
    required int galleryLength,
  }) {
    setState(() {
      if (isNextPage) {
        _currentPage++;
      } else {
        _currentPage--;
      }
      _controller.jumpToPage(_currentPage);
    });
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
        return Stack(
          children: [
            _buildGalleryContentViewer(
                context, maxSize, widget.contentBorderRadius),
            Positioned(
              bottom: bottomPos,
              left: leftRightPos,
              right: leftRightPos,
              child: _buildPageIndicator(indicatorSize),
            ),
          ],
        );
      },
    );
  }

  _openFullScreen() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => FullScreenPost(
    //       fullScreenMediaType: FullScreenMediaType.imageGallery,
    //       homeScreenPostData: widget.homeScreenPostData,
    //     ),
    //   ),
    // );
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

  _buildPageIndicator(Size indicatorSize) {
    int contentLength = widget.feedPostData.length;
    return SizedBox(
      width: indicatorSize.width,
      height: indicatorSize.height,
      child: contentLength <= widget.largeGalleryThreshold
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contentLength,
                (index) => _buildIndicator(indicatorSize, index),
              ),
            )
          : _pageIndicatorForLargeGallery(
              indicatorSize,
              contentLength,
            ),
    );
  }

  _buildIndicator(Size indicatorSize, int index) {
    double indicatorCircleSize =
        indicatorSize.width * (_currentPage == index ? 0.07 : 0.05);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: indicatorSize.width * 0.03,
      ),
      width: indicatorCircleSize,
      height: indicatorCircleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? kWhite : k1Gray,
      ),
    );
  }

  _pageIndicatorForLargeGallery(Size maxSize, int contentLength) {
    bool isNextButtonDisabled = _currentPage >= contentLength - 1;
    bool isBackButtonDisabled = _currentPage <= 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LinkWinIcon(
          iconSize: Size(maxSize.width * 0.25, maxSize.height),
          splashColor: isBackButtonDisabled ? transparent : k1Gray,
          iconData: Icons.arrow_back_ios_new_outlined,
          iconSizeRatio: 0.8,
          iconColor: isBackButtonDisabled ? k1Gray : kWhite,
          onTap: isBackButtonDisabled
              ? null
              : () =>
                  _jumpToPage(isNextPage: false, galleryLength: contentLength),
        ),
        Text(
          '${_currentPage + 1} / $contentLength',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: kWhite,
              ),
        ),
        LinkWinIcon(
          iconSize: Size(maxSize.width * 0.25, maxSize.height),
          splashColor: isNextButtonDisabled ? transparent : k1Gray,
          iconData: Icons.arrow_forward_ios_outlined,
          iconSizeRatio: 0.8,
          iconColor: isNextButtonDisabled ? k1Gray : kWhite,
          onTap: isNextButtonDisabled
              ? null
              : () =>
                  _jumpToPage(isNextPage: true, galleryLength: contentLength),
        ),
      ],
    );
  }
}
