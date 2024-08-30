import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/full_screen_media_type.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/post_widgets/gallery_content_viewer.dart';
import 'package:link_win_mob_app/widgets/post_actions_buttons.dart';
import 'package:link_win_mob_app/widgets/post_profile_details.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

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

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: kBlack,
      body: Stack(
        children: [
          _fetchRelevantWidget(
            screenUtil.size,
            iconSize,
            actionButtonsSize,
            profileDetailsSize,
          ),
          Positioned(
            top: 0,
            right: screenUtil.screenWidth * 0.02,
            child: _closeButton(context, iconSize),
          ),
          Positioned(
            bottom: screenUtil.screenHeight * 0.1,
            right: 0,
            child: _actionButtons(actionButtonsSize),
          ),
          Positioned(
            bottom: screenUtil.screenHeight * 0.075,
            left: screenUtil.screenWidth * 0.05,
            child: _profileDetails(profileDetailsSize),
          ),
        ],
      ),
    );
  }

  Widget _fetchRelevantWidget(
    Size screenSize,
    double iconSize,
    Size actionButtonsSize,
    Size profileDetailsSize,
  ) {
    switch (fullScreenMediaType) {
      case FullScreenMediaType.image:
        return _SingleImagePost(
          screenSize: screenSize,
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
          screenSize: screenSize,
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
          screenSize: screenSize,
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
          screenSize: screenSize,
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
    return PhotoView(
      imageProvider: NetworkImage(
        url,
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
    return SizedBox(
      child: GalleryContentViewer(
        contentBorderRadius: const BorderRadius.all(Radius.zero),
        homeScreenPostData: homeScreenPostData,
        bottomPosRatio: 0.15,
        indecatorWidthRatio: 0.4,
      ),
    );
  }
}

class _SingleVideoPost extends StatefulWidget {
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
  State<_SingleVideoPost> createState() => __SingleVideoPostState();
}

class __SingleVideoPostState extends State<_SingleVideoPost> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isMuted = true; // Add this state

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.homeScreenPostData.content[0],
      ),
    )
      ..initialize().then(
        (val) {
          setState(
            () {
              _controller.setVolume(_isMuted ? 0.0 : 1.0);
              _controller.play();
              _isPlaying = true;
            },
          );
        },
      )
      ..setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(
      () {
        if (_controller.value.isPlaying) {
          _controller.pause();
          _isPlaying = false;
        } else {
          _controller.play();
          _isPlaying = true;
        }
      },
    );
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final newPosition = _controller.value.position +
        Duration(
          milliseconds: (details.primaryDelta! * 100).toInt(),
        );
    _controller.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);

    return Scaffold(
      backgroundColor: kBlack,
      body: SafeArea(
        child: GestureDetector(
          onTap: _togglePlayPause,
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          child: Stack(
            children: [
              _videoPlayer(screenUtil),
              Visibility(
                visible: !_isPlaying,
                child: _playPauseButtons(
                  context,
                  screenUtil,
                ),
              ),
              _videoProgressIndicator(screenUtil),
              _muteButton(context, screenUtil),
            ],
          ),
        ),
      ),
    );
  }

  Widget _videoPlayer(ScreenUtil screenUtil) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(
                _controller,
              ),
            )
          : const CircularProgressIndicator(),
    );
  }

  Widget _videoProgressIndicator(ScreenUtil screenUtil) {
    double bottomPos = screenUtil.screenHeight * 0.02;
    double leftRightPos = screenUtil.screenWidth * 0.025;
    double indicatorHeight = screenUtil.screenHeight * 0.015;

    return Positioned(
      bottom: bottomPos,
      left: leftRightPos,
      right: leftRightPos,
      child: SizedBox(
        height: indicatorHeight,
        child: VideoProgressIndicator(
          _controller,
          allowScrubbing: true,
          colors: VideoProgressColors(
            backgroundColor: transparent,
            playedColor: kWhite,
            bufferedColor: kWhite.withOpacity(0.25),
          ),
        ),
      ),
    );
  }

  Widget _playPauseButtons(BuildContext context, ScreenUtil screenUtil) {
    double iconSize = screenUtil.screenWidth * 0.18;
    double leftRightPos = (screenUtil.screenWidth - iconSize) * 0.5;
    double bottomPos = (screenUtil.screenHeight - iconSize) * 0.5;
    return Positioned(
      bottom: bottomPos,
      left: leftRightPos,
      right: leftRightPos,
      child: Container(
        width: iconSize,
        height: iconSize,
        decoration: const BoxDecoration(
          color: k1Gray, // Background color of the button
          shape: BoxShape.circle, // Makes the container circular
        ),
        child: InkWell(
          onTap: _togglePlayPause,
          splashColor: k1Gray,
          child: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            color: kWhite,
            size: iconSize * 0.6,
          ),
        ),
      ),
    );
  }

  Widget _muteButton(BuildContext context, ScreenUtil screenUtil) {
    double iconSize = screenUtil.screenWidth * 0.1;
    double bottomPos = screenUtil.screenHeight * 0.05;
    double rightPos = screenUtil.screenWidth * 0.075;
    return Positioned(
      bottom: bottomPos,
      right: rightPos,
      child: Container(
        width: iconSize,
        height: iconSize,
        decoration: const BoxDecoration(
          color: k1Gray, // Background color of the button
          shape: BoxShape.circle, // Makes the container circular
        ),
        child: InkWell(
          onTap: _toggleMute,
          splashColor: k1Gray,
          child: Icon(
            _isMuted ? Icons.volume_off : Icons.volume_up,
            color: kWhite,
            size: iconSize * 0.6,
          ),
        ),
      ),
    );
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
