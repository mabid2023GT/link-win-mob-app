import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/home_screen_post_type.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:video_player/video_player.dart';

class HomeScreenPostBody extends StatelessWidget {
  final double borderRadiusPercentage;
  final HomeScreenPostData homeScreenPostData;
  const HomeScreenPostBody({
    super.key,
    required this.borderRadiusPercentage,
    required this.homeScreenPostData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(child: (minSize, maxSize) {
      BorderRadius contentBorderRadius = BorderRadius.only(
        topLeft: Radius.circular(
          maxSize.width * borderRadiusPercentage * 0.9,
        ),
        topRight: Radius.circular(
          maxSize.width * borderRadiusPercentage * 0.9,
        ),
      );
      return Container(
        width: maxSize.width,
        height: maxSize.height,
        decoration: BoxDecoration(
          color: transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              maxSize.width * borderRadiusPercentage,
            ),
            topRight: Radius.circular(
              maxSize.width * borderRadiusPercentage,
            ),
          ),
        ),
        child: _buildContentViewer(context, maxSize, contentBorderRadius),
      );
    });
  }

  _buildContentViewer(
      BuildContext context, Size maxSize, BorderRadius contentBorderRadius) {
    switch (homeScreenPostData.homeScreenPostType) {
      case HomeScreenPostType.image:
        return _buildImageContentViewer(maxSize, contentBorderRadius);
      case HomeScreenPostType.imageCollection:
        return Container(
          color: Colors.green,
        );
      case HomeScreenPostType.video:
        return VideoContentViewer(
          contentBorderRadius: contentBorderRadius,
          videoUrl: homeScreenPostData.content[0],
        );
      case HomeScreenPostType.videoCollection:
        return Container(
          color: Colors.pink,
        );
      case HomeScreenPostType.text:
        return Container(
          color: Colors.purple,
        );
    }
  }

  _buildImageContentViewer(Size maxSize, BorderRadius contentBorderRadius) {
    return ClipRRect(
      borderRadius: contentBorderRadius,
      child: Image.network(
        homeScreenPostData.content[0],
        width: maxSize.width,
        height: maxSize.height,
        fit: BoxFit.cover,
      ),
    );
  }
}

class VideoContentViewer extends StatefulWidget {
  final BorderRadius contentBorderRadius;
  final String videoUrl;
  const VideoContentViewer({
    super.key,
    required this.contentBorderRadius,
    required this.videoUrl,
  });

  @override
  State<VideoContentViewer> createState() => _VideoContentViewerState();
}

class _VideoContentViewerState extends State<VideoContentViewer> {
  late VideoPlayerController _controller;
  bool _hasError = false;
  bool _isVideoEnded = false;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then(
        (_) {
          if (mounted) {
            setState(() {
              _controller.setVolume(_isMuted ? 0.0 : 1.0);
              _controller.play();
            });
          }
        },
      ).catchError((error) {
        setState(() {
          _hasError = true;
        });
        debugPrint("Video initialization error: $error");
      });

    _controller.addListener(_videoPlayerListener);
  }

  void _videoPlayerListener() {
    if (_controller.value.position >= _controller.value.duration) {
      if (!_isVideoEnded) {
        setState(() {
          _isVideoEnded = true;
        });
      }
    }
  }

  void _replayVideo() {
    setState(() {
      _isVideoEnded = false; // Hide replay button
    });
    _controller.seekTo(Duration.zero).then((_) {
      _controller.play();
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_videoPlayerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const Center(
        child: Text(
          'Failed to load video',
          style: TextStyle(color: kRed),
        ),
      );
    }

    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        return Stack(
          children: [
            _videoViewerWidget(maxSize),
            if (_isVideoEnded) _replayButton(maxSize),
            _volumeButton(maxSize),
          ],
        );
      },
    );
  }

  Widget _volumeButton(Size maxSize) {
    double minDimension = maxSize.shortestSide;
    double buttonSize = minDimension * 0.1;
    return Positioned(
      bottom: minDimension * 0.05,
      right: minDimension * 0.05,
      child: InkWell(
        onTap: _toggleMute,
        splashColor: transparent,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: k1Gray.withOpacity(0.75),
          ),
          child: Icon(
            _isMuted ? Icons.volume_off : Icons.volume_up,
            color: kWhite,
            size: buttonSize * 0.7,
          ),
        ),
      ),
    );
  }

  Widget _videoViewerWidget(Size maxSize) {
    return SizedBox(
      width: maxSize.width,
      height: maxSize.height,
      child: _controller.value.isInitialized
          ? ClipRRect(
              borderRadius: widget.contentBorderRadius,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _replayButton(Size maxSize) {
    double minDimension = maxSize.shortestSide;
    double buttonSize = minDimension * 0.2;
    return Center(
      child: InkWell(
        onTap: _replayVideo,
        splashColor: transparent,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: k1Gray.withOpacity(0.75),
          ),
          child: Icon(
            Icons.replay,
            color: Colors.white,
            size: buttonSize * 0.7,
          ),
        ),
      ),
    );
  }
}
