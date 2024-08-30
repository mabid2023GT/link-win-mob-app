import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/full_screen_media_type.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/widgets/post_actions_buttons.dart';
import 'package:link_win_mob_app/widgets/post_profile_details.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenPost extends StatelessWidget {
  final FullScreenMediaType fullScreenMediaType;
  final List<String> urls;
  final HomeScreenPostData homeScreenPostData;

  const FullScreenPost({
    super.key,
    required this.fullScreenMediaType,
    required this.urls,
    required this.homeScreenPostData,
  });

  @override
  Widget build(BuildContext context) {
    switch (fullScreenMediaType) {
      case FullScreenMediaType.image:
        return SingleImagePost(
          url: urls[0],
          homeScreenPostData: homeScreenPostData,
        );
      case FullScreenMediaType.imageGallery:
        return GalleryImagePost(
          urls: urls,
          homeScreenPostData: homeScreenPostData,
        );
      case FullScreenMediaType.video:
        return SingleVideoPost(
          url: urls[0],
          homeScreenPostData: homeScreenPostData,
        );
      case FullScreenMediaType.videos:
        return VideosPost(
          urls: urls,
          homeScreenPostData: homeScreenPostData,
        );
      default:
        return Container();
    }
  }
}

class SingleImagePost extends StatelessWidget {
  final String url;
  final HomeScreenPostData homeScreenPostData;

  const SingleImagePost({
    super.key,
    required this.url,
    required this.homeScreenPostData,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);
    double shortestSide = screenUtil.size.shortestSide;
    double iconSize = shortestSide * 0.11;
    Size actionButtonsSize = Size(
      screenUtil.screenWidth * 0.25,
      screenUtil.screenHeight * 0.5,
    );

    Size profileDetailsSize = Size(
      screenUtil.screenWidth * 0.7,
      screenUtil.screenHeight * 0.08,
    );

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PhotoView(
              imageProvider: NetworkImage(
                url[0],
              ),
            ),
            Positioned(
              top: screenUtil.screenHeight * 0.05,
              right: screenUtil.screenWidth * 0.05,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: k1Gray.withOpacity(0.75),
                  ),
                  child: Icon(
                    Icons.close,
                    size: iconSize * 0.8,
                    color: kWhite,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: screenUtil.screenHeight * 0.05,
              right: screenUtil.screenWidth * 0.025,
              child: Container(
                width: actionButtonsSize.width,
                height: actionButtonsSize.height,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(actionButtonsSize.width * 0.3),
                ),
                child: PostActionsButtons(
                  isRow: false,
                  homeScreenPostData: homeScreenPostData,
                ),
              ),
            ),
            Positioned(
              bottom: screenUtil.screenHeight * 0.05,
              left: screenUtil.screenWidth * 0.05,
              child: SizedBox(
                width: profileDetailsSize.width,
                height: profileDetailsSize.height,
                child: PostProfileDetails(
                  withMoreVertIcon: false,
                  homeScreenPostData: homeScreenPostData,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleVideoPost extends StatelessWidget {
  final String url;
  final HomeScreenPostData homeScreenPostData;
  const SingleVideoPost({
    super.key,
    required this.url,
    required this.homeScreenPostData,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class GalleryImagePost extends StatelessWidget {
  final HomeScreenPostData homeScreenPostData;
  final List<String> urls;
  const GalleryImagePost({
    super.key,
    required this.homeScreenPostData,
    required this.urls,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              itemCount: urls.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(
                    urls[index],
                  ),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class VideosPost extends StatelessWidget {
  final HomeScreenPostData homeScreenPostData;
  final List<String> urls;
  const VideosPost({
    super.key,
    required this.homeScreenPostData,
    required this.urls,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
