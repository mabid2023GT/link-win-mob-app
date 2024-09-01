import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CircularVideoProgressIndicator extends StatelessWidget {
  final VideoPlayerController videoController;
  final Size videoProgressIndicatorSize;
  final double topBottomPadd;
  final double leftRightPadd;

  const CircularVideoProgressIndicator({
    super.key,
    required this.videoController,
    required this.videoProgressIndicatorSize,
    required this.topBottomPadd,
    required this.leftRightPadd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      child: Container(
        width: videoProgressIndicatorSize.width,
        height: videoProgressIndicatorSize.height,
        padding: EdgeInsets.only(
          top: topBottomPadd,
          bottom: topBottomPadd,
          left: leftRightPadd,
          right: leftRightPadd,
        ),
        child: _videoProgressIndicator(),
      ),
    );
  }

  Widget _videoProgressIndicator() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(videoProgressIndicatorSize.width),
      child: VideoProgressIndicator(
        videoController,
        allowScrubbing: true,
        colors: VideoProgressColors(
          backgroundColor: Colors.transparent,
          playedColor: Colors.white,
          bufferedColor: Colors.white.withOpacity(0.25),
        ),
      ),
    );
  }

  _onHorizontalDragUpdate(DragUpdateDetails details) {
    {
      if (videoController.value.isInitialized) {
        final currentPosition = videoController.value.position;
        final newPosition = currentPosition +
            Duration(
              milliseconds: (details.primaryDelta! * 100).toInt(),
            );
        videoController.seekTo(newPosition);
      }
    }
  }
}
