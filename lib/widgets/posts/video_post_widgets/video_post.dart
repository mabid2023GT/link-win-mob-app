import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_data.dart';
import 'package:link_win_mob_app/providers/home/feed_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:link_win_mob_app/widgets/posts/video_post_widgets/video_player_controls_bar.dart';
import 'package:video_player/video_player.dart';

class SingleVideoPost extends ConsumerStatefulWidget {
  final String url;
  final FeedPostData feedPostData;
  final int videoIndex;
  final Size footerSize;

  const SingleVideoPost({
    super.key,
    required this.url,
    required this.feedPostData,
    required this.videoIndex,
    required this.footerSize,
  });

  @override
  ConsumerState<SingleVideoPost> createState() => SingleVideoPostState();
}

class SingleVideoPostState extends ConsumerState<SingleVideoPost> {
  late VideoPlayerController controller;
  bool _isInPlayMode = true;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.url,
      ),
    )..initialize().then((val) {
        setState(() {
          controller.setLooping(true);
          // Accessing the mute state using the new method in initState
          final isMuted = ref
              .read(feedProvider.notifier)
              .isMutedForPage(widget.feedPostData.pageIndex);
          // Set the volume based on the mute state
          controller.setVolume(isMuted ? 0.0 : 1.0);
          controller.play();
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(
      () {
        if (controller.value.isPlaying) {
          controller.pause();
          _isInPlayMode = false;
        } else {
          controller.play();
          _isInPlayMode = true;
        }
      },
    );
  }

  void _handleVideoTap() {
    setState(() {
      _isInPlayMode = !_isInPlayMode;
    });
    if (_isInPlayMode) {
      controller.play();
    } else {
      controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        return Scaffold(
          backgroundColor: kBlack,
          body: SizedBox(
            width: maxSize.width,
            height: maxSize.height,
            child: SafeArea(
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: Stack(
                  children: [
                    _videoViewerWidget(maxSize),
                    if (!_isInPlayMode) _playPauseButtons(context, maxSize),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: _videoControlsBar(widget.footerSize),
        );
      },
    );
  }

  _videoControlsBar(
    Size footerSize,
  ) {
    return Container(
      width: footerSize.width,
      height: footerSize.height,
      color: transparent,
      child: controller.value.isInitialized
          ? VideoPlayerControlsBar(
              videoController: controller,
              ref: ref,
              feedPostData: widget.feedPostData,
            )
          : const SizedBox(),
    );
  }

  Widget _videoViewerWidget(Size maxSize) {
    return GestureDetector(
      onTap: _handleVideoTap,
      child: SizedBox(
        width: maxSize.width,
        height: maxSize.height,
        child: controller.value.isInitialized
            ? ClipRRect(
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget _playPauseButtons(BuildContext context, Size parentSize) {
    double iconSize = parentSize.width * 0.18;
    double leftRightPos = (parentSize.width - iconSize) * 0.5;
    double bottomPos = (parentSize.height - iconSize) * 0.5;
    return Positioned(
      bottom: bottomPos,
      left: leftRightPos,
      right: leftRightPos,
      child: LinkWinIcon(
        iconSize: Size(iconSize, iconSize),
        iconSizeRatio: 0.6,
        iconColor: kWhite,
        iconData: _isInPlayMode ? Icons.pause : Icons.play_arrow,
        splashColor: k1Gray,
        backgroundColor: k1Gray,
        onTap: _togglePlayPause,
      ),
    );
  }
}

class VideosPost extends ConsumerWidget {
  final FeedPostData feedPostData;
  final List<String> urls;
  final Size footerSize;
  final ValueNotifier<int> currentIndexNotifier;

  const VideosPost({
    super.key,
    required this.feedPostData,
    required this.urls,
    required this.footerSize,
    required this.currentIndexNotifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> content = feedPostData.content;
    return PageView.builder(
      itemCount: content.length,
      scrollDirection: Axis.horizontal,
      onPageChanged: (int index) => currentIndexNotifier.value = index,
      itemBuilder: (context, index) {
        return SingleVideoPost(
          url: content[index],
          feedPostData: feedPostData,
          videoIndex: index,
          footerSize: footerSize,
        );
      },
    );
  }
}
