import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/full_screen_media_type.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/full_screen_post.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryContentViewer extends StatefulWidget {
  final BorderRadius contentBorderRadius;
  final HomeScreenPostData homeScreenPostData;

  const GalleryContentViewer({
    super.key,
    required this.contentBorderRadius,
    required this.homeScreenPostData,
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
        double bottomPos = maxSize.height * 0.025;
        return Stack(
          children: [
            _buildGalleryContentViewer(
                context, maxSize, widget.contentBorderRadius),
            Positioned(
              bottom: bottomPos,
              left: 0,
              right: 0,
              child: _buildPageIndicator(maxSize),
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
          fullScreenMediaType: FullScreenMediaType.imageGallery,
          urls: widget.homeScreenPostData.content,
          homeScreenPostData: widget.homeScreenPostData,
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
          itemCount: widget.homeScreenPostData.content.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                widget.homeScreenPostData.content[index],
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

  _buildPageIndicator(Size maxSize) {
    int contentLength = widget.homeScreenPostData.content.length;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          maxSize.height * 0.05,
        ),
        color: transparent,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: contentLength <= 5
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contentLength,
                (index) => _buildIndicator(index),
              ),
            )
          : _pageIndicatorForLargeGallery(
              maxSize,
              contentLength,
            ),
    );
  }

  _buildIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ),
      width: _currentPage == index ? 12.0 : 8.0,
      height: _currentPage == index ? 12.0 : 8.0,
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
        Material(
          color: transparent,
          child: InkWell(
            onTap: isBackButtonDisabled
                ? null
                : () => _jumpToPage(
                    isNextPage: false, galleryLength: contentLength),
            splashColor: isBackButtonDisabled ? transparent : k1Gray,
            customBorder: const CircleBorder(),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: isBackButtonDisabled ? k1Gray : kWhite,
            ),
          ),
        ),
        Text(
          '${_currentPage + 1} / $contentLength',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: kWhite,
              ),
        ),
        Material(
          color: transparent,
          child: InkWell(
            onTap: isNextButtonDisabled
                ? null
                : () =>
                    _jumpToPage(isNextPage: true, galleryLength: contentLength),
            splashColor: isNextButtonDisabled ? transparent : k1Gray,
            customBorder: const CircleBorder(),
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: isNextButtonDisabled ? k1Gray : kWhite,
            ),
          ),
        ),
      ],
    );
  }
}
