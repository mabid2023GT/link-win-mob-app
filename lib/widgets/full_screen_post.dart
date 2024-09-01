import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/full_screen_media_type.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/post_widgets/gallery_content_viewer.dart';
import 'package:link_win_mob_app/widgets/full_screen_post_app_bar.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:link_win_mob_app/widgets/post_actions_buttons.dart';
import 'package:link_win_mob_app/widgets/post_profile_details.dart';
import 'package:link_win_mob_app/widgets/video_player_controls_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final muteProvider = StateProvider<bool>((ref) => true);
final videoControllerProvider =
    StateProvider<VideoPlayerController?>((ref) => null);

class FullScreenPost extends ConsumerWidget {
  final FullScreenMediaType fullScreenMediaType;
  final HomeScreenPostData homeScreenPostData;
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier(1);

  FullScreenPost({
    super.key,
    required this.fullScreenMediaType,
    required this.homeScreenPostData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtil screenUtil = ScreenUtil(context);
    Size appbarSize =
        Size(screenUtil.screenWidth, screenUtil.screenHeight * 0.075);
    Size footerSize =
        Size(screenUtil.screenWidth, screenUtil.screenHeight * 0.1);
    Size bodySize = Size(screenUtil.screenWidth,
        screenUtil.screenHeight - appbarSize.height - footerSize.height);

    return Scaffold(
      backgroundColor: kBlack,
      appBar: FullScreenPostAppBar(
        currentIndexNotifier: currentIndexNotifier,
        totalItems: homeScreenPostData.length,
        appbarSize: appbarSize,
      ),
      body: SizedBox(
        width: bodySize.width,
        height: bodySize.height,
        child: _bodyWrapper(bodySize),
      ),
      bottomNavigationBar: SizedBox(
        width: footerSize.width,
        height: footerSize.height,
        child: VideoPlayerControlsBar(
            ref: ref,
            videoControllerProvider: videoControllerProvider,
            muteProvider: muteProvider),
      ),
    );
  }

  Widget _bodyWrapper(Size size) {
    Size actionButtonsSize = Size(size.width * 0.2, size.height * 0.65);
    Size profileDetailsSize =
        Size(size.width - actionButtonsSize.width, size.height * 0.1);
    return Stack(
      children: [
        _fetchRelevantWidget(),
        Positioned(
          bottom: 0,
          right: 0,
          child: _actionButtons(
            actionButtonsSize,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: _profileDetails(profileDetailsSize),
        ),
      ],
    );
  }

  Widget _fetchRelevantWidget() {
    switch (fullScreenMediaType) {
      case FullScreenMediaType.image:
        return _SingleImagePost(
          url: homeScreenPostData.content[0],
          homeScreenPostData: homeScreenPostData,
        );
      case FullScreenMediaType.imageGallery:
        return _GalleryImagePost(
          urls: homeScreenPostData.content,
          homeScreenPostData: homeScreenPostData,
        );
      case FullScreenMediaType.video:
        return _SingleVideoPost(
          url: homeScreenPostData.content[0],
        );
      case FullScreenMediaType.videos:
        return _VideosPost(
          urls: homeScreenPostData.content,
          homeScreenPostData: homeScreenPostData,
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
  final String url;
  final HomeScreenPostData homeScreenPostData;

  const _SingleImagePost({
    required this.url,
    required this.homeScreenPostData,
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
  final HomeScreenPostData homeScreenPostData;
  final List<String> urls;

  const _GalleryImagePost({
    required this.homeScreenPostData,
    required this.urls,
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

class _SingleVideoPost extends ConsumerStatefulWidget {
  final String url;

  const _SingleVideoPost({
    required this.url,
  });

  @override
  ConsumerState<_SingleVideoPost> createState() => __SingleVideoPostState();
}

class __SingleVideoPostState extends ConsumerState<_SingleVideoPost> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.url,
      ),
    )
      ..initialize().then(
        (val) {
          setState(
            () {
              _controller.setVolume(ref.read(muteProvider) ? 0.0 : 1.0);
              _controller.play();
              _isPlaying = true;
            },
          );
          // Update provider with the video controller
          ref.read(videoControllerProvider.notifier).state = _controller;
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

    // Watch the muteProvider
    bool isMuted = ref.watch(muteProvider);
    // Set the volume based on the current mute state
    _controller.setVolume(isMuted ? 0.0 : 1.0);

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

  Widget _playPauseButtons(BuildContext context, ScreenUtil screenUtil) {
    double iconSize = screenUtil.screenWidth * 0.18;
    double leftRightPos = (screenUtil.screenWidth - iconSize) * 0.5;
    double bottomPos = (screenUtil.screenHeight - iconSize) * 0.5;
    return Positioned(
      bottom: bottomPos,
      left: leftRightPos,
      right: leftRightPos,
      child: LinkWinIcon(
        iconSize: Size(iconSize, iconSize),
        iconSizeRatio: 0.6,
        iconColor: kWhite,
        iconData: _isPlaying ? Icons.pause : Icons.play_arrow,
        splashColor: k1Gray,
        backgroundColor: k1Gray,
        onTap: _togglePlayPause,
      ),
    );
  }
}

class _VideosPost extends StatelessWidget {
  final HomeScreenPostData homeScreenPostData;
  final List<String> urls;

  const _VideosPost({
    required this.homeScreenPostData,
    required this.urls,
  });

  @override
  Widget build(BuildContext context) {
    List<String> content = homeScreenPostData.content;
    return PageView.builder(
      itemCount: content.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return _SingleVideoPost(
          url: content[index],
        );
      },
    );
  }
}
