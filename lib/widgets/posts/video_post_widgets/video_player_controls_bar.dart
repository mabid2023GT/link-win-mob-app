import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_data.dart';
import 'package:link_win_mob_app/core/utils/extensions/duration_extensions.dart';
import 'package:link_win_mob_app/providers/home/feed_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/circular_video_progress_indicator.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControlsBar extends StatefulWidget {
  final VideoPlayerController videoController;
  final WidgetRef ref;
  final FeedPostData feedPostData;
  const VideoPlayerControlsBar({
    super.key,
    required this.videoController,
    required this.ref,
    required this.feedPostData,
  });

  @override
  State<VideoPlayerControlsBar> createState() => _VideoPlayerControlsBarState();
}

class _VideoPlayerControlsBarState extends State<VideoPlayerControlsBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size sideSize = Size(maxSize.width * 0.2, maxSize.height);
        Size videoControllerSize =
            Size(maxSize.width - 2 * sideSize.width, sideSize.height);

        return _body(
          maxSize,
          sideSize,
          videoControllerSize,
        );
      },
    );
  }

  Widget _body(
    Size size,
    Size sideSize,
    Size videoControllerSize,
  ) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _leftSide(sideSize),
          _videoController(videoControllerSize),
          _rightSide(sideSize),
        ],
      ),
    );
  }

  // Toggling the mute state
  void _toggleMute() {
    setState(() {
      // Toggle mute when the video is tapped
      widget.ref
          .read(feedProvider.notifier)
          .toggleMuteForPage(widget.feedPostData.pageIndex);
      // Update volume based on the new mute state
      final isMuted = widget.ref
          .read(feedProvider.notifier)
          .isMutedForPage(widget.feedPostData.pageIndex);
      widget.videoController.setVolume(isMuted ? 0.0 : 1.0);
    });
  }

  _leftSide(Size size) {
    Size positionTimeSize = Size(size.width, size.height * 0.4);
    Size muteIconSize =
        Size(positionTimeSize.width, size.height - positionTimeSize.height);

    final isMuted = widget.ref
        .read(feedProvider.notifier)
        .isMutedForPage(widget.feedPostData.pageIndex);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _positionTimeWidget(positionTimeSize),
        _buttonWrapper(
          muteIconSize,
          isMuted ? Icons.volume_off : Icons.volume_up,
          iconSizeRatio: 0.7,
          _toggleMute,
        ),
      ],
    );
  }

  _rightSide(Size size) {
    Size durationTimeSize = Size(size.width, size.height * 0.4);
    Size fullscreenIconSize =
        Size(durationTimeSize.width, size.height - durationTimeSize.height);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _durationTimeWidget(durationTimeSize),
        _buttonWrapper(
          fullscreenIconSize,
          Icons.fullscreen_exit_outlined,
          iconSizeRatio: 0.9,
          () {},
        ),
      ],
    );
  }

  Widget _positionTimeWidget(Size size) {
    return !widget.videoController.value.isInitialized
        ? const SizedBox()
        : ValueListenableBuilder(
            valueListenable: widget.videoController,
            builder: (context, VideoPlayerValue value, child) {
              final position = value.position;
              return Container(
                alignment: Alignment.center,
                width: size.width,
                height: size.height,
                child: Text(
                  position.formatVideoTime(),
                  style: const TextStyle(color: kWhite),
                ),
              );
            },
          );
  }

  Widget _durationTimeWidget(Size size) {
    return !widget.videoController.value.isInitialized
        ? const SizedBox()
        : ValueListenableBuilder(
            valueListenable: widget.videoController,
            builder: (context, VideoPlayerValue value, child) {
              final duration = value.duration;
              return Container(
                alignment: Alignment.center,
                width: size.width,
                height: size.height,
                child: Text(
                  duration.formatVideoTime(),
                  style: const TextStyle(color: kWhite),
                ),
              );
            },
          );
  }

  Widget _videoController(Size videoControllerSize) {
    Size videoProgressIndicatorSize =
        Size(videoControllerSize.width, videoControllerSize.height * 0.4);
    Size videoTimeSize =
        Size(videoControllerSize.width, videoControllerSize.height * 0.4);
    double topBottomPadd = videoProgressIndicatorSize.height * 0.3;
    double leftRightPadd = videoProgressIndicatorSize.width * 0.05;
    return !widget.videoController.value.isInitialized
        ? SizedBox(
            width: videoControllerSize.width,
            height: videoControllerSize.height,
          )
        : SizedBox(
            width: videoControllerSize.width,
            height: videoControllerSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularVideoProgressIndicator(
                  videoController: widget.videoController,
                  videoProgressIndicatorSize: videoProgressIndicatorSize,
                  topBottomPadd: topBottomPadd,
                  leftRightPadd: leftRightPadd,
                ),
                _videoActionBar(videoTimeSize, widget.videoController),
                SizedBox(
                  height: videoControllerSize.height -
                      videoProgressIndicatorSize.height -
                      videoTimeSize.height,
                ),
              ],
            ),
          );
  }

  Widget _videoActionBar(
    Size videoTimeSize,
    VideoPlayerController videoController,
  ) {
    double leftRightPad = videoTimeSize.width * 0.05;

    return Container(
      width: videoTimeSize.width,
      height: videoTimeSize.height,
      padding: EdgeInsets.only(
        left: leftRightPad,
        right: leftRightPad,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _replay10Icon(videoTimeSize, videoController),
          _playPauseIcon(videoController, videoTimeSize),
          _forward10Icon(videoTimeSize, videoController),
        ],
      ),
    );
  }

  Widget _playPauseIcon(
      VideoPlayerController videoController, Size videoTimeSize) {
    return ValueListenableBuilder(
      valueListenable: videoController,
      builder: (context, value, child) => LinkWinIcon(
        iconSize: Size(videoTimeSize.shortestSide, videoTimeSize.shortestSide),
        iconSizeRatio: 0.7,
        iconColor: kWhite,
        iconData: value.isPlaying ? Icons.pause : Icons.play_arrow,
        backgroundColor: k1Gray,
        splashColor: kWhite,
        onTap: () {
          if (videoController.value.isPlaying) {
            videoController.pause();
          } else {
            videoController.play();
          }
        },
      ),
    );
  }

  Widget _forward10Icon(
      Size videoTimeSize, VideoPlayerController videoController) {
    return LinkWinIcon(
      iconSize: Size(videoTimeSize.shortestSide, videoTimeSize.shortestSide),
      iconSizeRatio: 0.7,
      iconColor: kWhite,
      iconData: Icons.forward_10,
      backgroundColor: k1Gray,
      splashColor: kWhite,
      onTap: () {
        final currentPosition = videoController.value.position;
        final newPosition = currentPosition + const Duration(seconds: 10);
        videoController.seekTo(newPosition);
      },
    );
  }

  Widget _replay10Icon(
      Size videoTimeSize, VideoPlayerController videoController) {
    return LinkWinIcon(
      iconSize: Size(videoTimeSize.shortestSide, videoTimeSize.shortestSide),
      iconSizeRatio: 0.7,
      iconColor: kWhite,
      iconData: Icons.replay_10,
      backgroundColor: k1Gray,
      splashColor: kWhite,
      onTap: () {
        final currentPosition = videoController.value.position;
        final newPosition = currentPosition -
            const Duration(
              seconds: 10,
            );
        videoController.seekTo(newPosition);
      },
    );
  }

  Widget _buttonWrapper(Size size, IconData iconData, VoidCallback onTap,
      {double iconSizeRatio = 0.6}) {
    double leftRightPad = size.width * 0.15;
    double topBottomPad = size.height * 0.15;
    Size iconSize = Size(
      size.width - 2 * leftRightPad,
      size.height - 2 * topBottomPad,
    );
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: leftRightPad,
          right: leftRightPad,
          top: topBottomPad,
          bottom: topBottomPad,
        ),
        child: LinkWinIcon(
          iconSize: iconSize,
          iconSizeRatio: iconSizeRatio,
          iconColor: kWhite,
          iconData: iconData,
          splashColor: k1Gray,
          backgroundColor: k1Gray,
          onTap: onTap,
        ),
      ),
    );
  }
}
