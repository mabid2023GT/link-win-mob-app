import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/full_screen_media_type.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/full_screen_post.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:video_player/video_player.dart';

class VideosContentViewer extends StatelessWidget {
  final BorderRadius contentBorderRadius;
  final HomeScreenPostData homeScreenPostData;
  const VideosContentViewer({
    super.key,
    required this.contentBorderRadius,
    required this.homeScreenPostData,
  });

  @override
  Widget build(BuildContext context) {
    List<String> content = homeScreenPostData.content;
    return PageView.builder(
      itemCount: content.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return VideoContentViewer(
          contentBorderRadius: contentBorderRadius,
          homeScreenPostData: homeScreenPostData,
          url: content[index],
        );
      },
    );
  }
}

class VideoContentViewer extends StatefulWidget {
  final BorderRadius contentBorderRadius;
  final HomeScreenPostData homeScreenPostData;
  final String url;

  const VideoContentViewer({
    super.key,
    required this.contentBorderRadius,
    required this.homeScreenPostData,
    required this.url,
  });

  @override
  State<VideoContentViewer> createState() => _VideoContentViewerState();
}

class _VideoContentViewerState extends State<VideoContentViewer> {
  late VideoPlayerController controller;
  bool _isMuted = true;
  bool _isInPlayMode = true;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    )..initialize().then(
        (value) {
          setState(() {
            controller.setLooping(true);
            controller.setVolume(_isMuted ? 0.0 : 1.0);
            controller.play();
          });
        },
      );
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
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

  void _handleVideoDoubleTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenPost(
          fullScreenMediaType: FullScreenMediaType.video,
          homeScreenPostData: widget.homeScreenPostData,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        return Stack(
          children: [
            _videoViewerWidget(maxSize),
            _volumeButton(maxSize),
            if (!_isInPlayMode) _playModeIcon(maxSize),
          ],
        );
      },
    );
  }

  Widget _videoViewerWidget(Size maxSize) {
    return GestureDetector(
      onTap: _handleVideoTap,
      onDoubleTap: _handleVideoDoubleTap,
      child: SizedBox(
        width: maxSize.width,
        height: maxSize.height,
        child: controller.value.isInitialized
            ? ClipRRect(
                borderRadius: widget.contentBorderRadius,
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

  Widget _volumeButton(Size maxSize) {
    double minDimension = maxSize.shortestSide;
    double buttonSize = minDimension * 0.1;
    return Positioned(
      bottom: minDimension * 0.05,
      right: minDimension * 0.05,
      child: LinkWinIcon(
        iconSize: Size(buttonSize, buttonSize),
        splashColor: transparent,
        backgroundColor: k1Gray.withOpacity(0.75),
        iconColor: kWhite,
        iconSizeRatio: 0.7,
        iconData: _isMuted ? Icons.volume_off : Icons.volume_up,
        onTap: _toggleMute,
      ),
    );
  }

  _playModeIcon(Size maxSize) {
    double iconSize = maxSize.width * 0.15;
    double iconContainerSize = iconSize * 1.1;
    return Center(
      child: LinkWinIcon(
        iconSize: Size(iconContainerSize, iconContainerSize),
        splashColor: transparent,
        backgroundColor: k1Gray.withOpacity(0.75),
        iconColor: kWhite,
        iconSizeRatio: iconSize / iconContainerSize,
        iconData: Icons.play_arrow,
        onTap: _handleVideoTap,
      ),
    );
  }
}
