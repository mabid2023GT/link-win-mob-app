import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/full_screen_media_type.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/post_widgets/gallery_content_viewer.dart';
import 'package:link_win_mob_app/widgets/post_actions_buttons.dart';
import 'package:link_win_mob_app/widgets/post_profile_details.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenPost extends StatelessWidget {
  final FullScreenMediaType fullScreenMediaType;
  final HomeScreenPostData homeScreenPostData;

  const FullScreenPost({
    super.key,
    required this.fullScreenMediaType,
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

    switch (fullScreenMediaType) {
      case FullScreenMediaType.image:
        return _SingleImagePost(
          screenSize: screenUtil.size,
          iconSize: iconSize,
          actionButtonsSize: actionButtonsSize,
          profileDetailsSize: profileDetailsSize,
          url: homeScreenPostData.content[0],
          homeScreenPostData: homeScreenPostData,
          profileDetails: _profileDetails,
          actionButtons: _actionButtons,
          closeButton: _closeButton,
        );
      case FullScreenMediaType.imageGallery:
        return _GalleryImagePost(
          screenSize: screenUtil.size,
          iconSize: iconSize,
          actionButtonsSize: actionButtonsSize,
          profileDetailsSize: profileDetailsSize,
          urls: homeScreenPostData.content,
          homeScreenPostData: homeScreenPostData,
          profileDetails: _profileDetails,
          actionButtons: _actionButtons,
          closeButton: _closeButton,
        );
      case FullScreenMediaType.video:
        return _SingleVideoPost(
          screenSize: screenUtil.size,
          iconSize: iconSize,
          actionButtonsSize: actionButtonsSize,
          profileDetailsSize: profileDetailsSize,
          url: homeScreenPostData.content[0],
          homeScreenPostData: homeScreenPostData,
          profileDetails: _profileDetails,
          actionButtons: _actionButtons,
          closeButton: _closeButton,
        );
      case FullScreenMediaType.videos:
        return _VideosPost(
          screenSize: screenUtil.size,
          iconSize: iconSize,
          actionButtonsSize: actionButtonsSize,
          profileDetailsSize: profileDetailsSize,
          urls: homeScreenPostData.content,
          homeScreenPostData: homeScreenPostData,
          profileDetails: _profileDetails,
          actionButtons: _actionButtons,
          closeButton: _closeButton,
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
        homeScreenPostData: homeScreenPostData,
      ),
    );
  }

  Widget _closeButton(BuildContext context, double iconSize) {
    return InkWell(
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
    );
  }

  Widget _profileDetails(Size profileDetailsSize) {
    return SizedBox(
      width: profileDetailsSize.width,
      height: profileDetailsSize.height,
      child: PostProfileDetails(
        withMoreVertIcon: false,
        homeScreenPostData: homeScreenPostData,
      ),
    );
  }
}

class _SingleImagePost extends StatelessWidget {
  final double iconSize;
  final Size screenSize;
  final Size actionButtonsSize;
  final Size profileDetailsSize;
  final String url;
  final HomeScreenPostData homeScreenPostData;
  // functions as params
  final Widget Function(Size profileDetailsSize) profileDetails;
  final Widget Function(BuildContext context, double iconSize) closeButton;
  final Widget Function(Size actionButtonsSize) actionButtons;

  const _SingleImagePost({
    required this.url,
    required this.homeScreenPostData,
    required this.iconSize,
    required this.actionButtonsSize,
    required this.profileDetailsSize,
    required this.screenSize,
    required this.profileDetails,
    required this.closeButton,
    required this.actionButtons,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PhotoView(
              imageProvider: NetworkImage(
                url,
              ),
            ),
            Positioned(
              top: screenSize.height * 0.05,
              right: screenSize.width * 0.05,
              child: closeButton(context, iconSize),
            ),
            Positioned(
              bottom: screenSize.height * 0.05,
              right: screenSize.width * 0.025,
              child: actionButtons(actionButtonsSize),
            ),
            Positioned(
              bottom: screenSize.height * 0.05,
              left: screenSize.width * 0.05,
              child: profileDetails(profileDetailsSize),
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryImagePost extends StatelessWidget {
  final double iconSize;
  final Size screenSize;
  final Size actionButtonsSize;
  final Size profileDetailsSize;
  final HomeScreenPostData homeScreenPostData;
  final List<String> urls;
  // functions as params
  final Widget Function(Size profileDetailsSize) profileDetails;
  final Widget Function(BuildContext context, double iconSize) closeButton;
  final Widget Function(Size actionButtonsSize) actionButtons;
  const _GalleryImagePost({
    required this.homeScreenPostData,
    required this.urls,
    required this.iconSize,
    required this.actionButtonsSize,
    required this.profileDetailsSize,
    required this.screenSize,
    required this.profileDetails,
    required this.closeButton,
    required this.actionButtons,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GalleryContentViewer(
              contentBorderRadius: const BorderRadius.all(Radius.zero),
              homeScreenPostData: homeScreenPostData,
              bottomPosRatio: 0.15,
              indecatorWidthRatio: 0.4,
            ),
            Positioned(
              top: screenSize.height * 0.05,
              right: screenSize.width * 0.05,
              child: closeButton(context, iconSize),
            ),
            Positioned(
              bottom: screenSize.height * 0.05,
              right: screenSize.width * 0.025,
              child: actionButtons(actionButtonsSize),
            ),
            Positioned(
              bottom: screenSize.height * 0.05,
              left: screenSize.width * 0.05,
              child: profileDetails(profileDetailsSize),
            ),
          ],
        ),
      ),
    );
  }
}

class _SingleVideoPost extends StatelessWidget {
  final double iconSize;
  final Size screenSize;
  final Size actionButtonsSize;
  final Size profileDetailsSize;
  final String url;
  final HomeScreenPostData homeScreenPostData;
  // functions as params
  final Widget Function(Size profileDetailsSize) profileDetails;
  final Widget Function(BuildContext context, double iconSize) closeButton;
  final Widget Function(Size actionButtonsSize) actionButtons;
  const _SingleVideoPost({
    required this.url,
    required this.homeScreenPostData,
    required this.iconSize,
    required this.actionButtonsSize,
    required this.profileDetailsSize,
    required this.screenSize,
    required this.profileDetails,
    required this.closeButton,
    required this.actionButtons,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _VideosPost extends StatelessWidget {
  final double iconSize;
  final Size screenSize;
  final Size actionButtonsSize;
  final Size profileDetailsSize;
  final HomeScreenPostData homeScreenPostData;
  final List<String> urls;
  // functions as params
  final Widget Function(Size profileDetailsSize) profileDetails;
  final Widget Function(BuildContext context, double iconSize) closeButton;
  final Widget Function(Size actionButtonsSize) actionButtons;
  const _VideosPost({
    required this.homeScreenPostData,
    required this.urls,
    required this.iconSize,
    required this.actionButtonsSize,
    required this.profileDetailsSize,
    required this.screenSize,
    required this.profileDetails,
    required this.closeButton,
    required this.actionButtons,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
