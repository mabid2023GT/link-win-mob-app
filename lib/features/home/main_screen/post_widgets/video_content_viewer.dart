import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_state.dart';
import 'package:link_win_mob_app/providers/home/post_feed_controller.dart';
import 'package:link_win_mob_app/providers/home/post_feed_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:video_player/video_player.dart';

class VideosContentViewer extends StatelessWidget {
  final BorderRadius contentBorderRadius;
  final HomeScreenPostState postState;
  const VideosContentViewer({
    super.key,
    required this.contentBorderRadius,
    required this.postState,
  });

  @override
  Widget build(BuildContext context) {
    List<String> content = postState.homeScreenPostData.content;
    return PageView.builder(
      itemCount: content.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return VideoContentViewer(
          contentBorderRadius: contentBorderRadius,
          postState: postState,
          url: content[index],
        );
      },
    );
  }
}

class VideoContentViewer extends ConsumerStatefulWidget {
  final BorderRadius contentBorderRadius;
  final HomeScreenPostState postState;
  final String url;

  const VideoContentViewer({
    super.key,
    required this.contentBorderRadius,
    required this.postState,
    required this.url,
  });

  @override
  VideoContentViewerState createState() => VideoContentViewerState();
}

class VideoContentViewerState extends ConsumerState<VideoContentViewer> {
  @override
  void initState() {
    super.initState();
    // Initialize the video controller when the widget is first created
    WidgetsBinding.instance.addPostFrameCallback((val) {
      ref.read(postFeedProvider.notifier).initializeVideoController(
            widget.postState.homeScreenPostData.postId,
            widget.url,
          );
    });
  }

  @override
  void dispose() {
    // Dispose of the video controller when the widget is disposed
    ref.read(postFeedProvider.notifier).disposeVideoController(
          widget.postState.homeScreenPostData.postId,
        );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(postFeedProvider.notifier);

    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        return Stack(
          children: [
            _videoViewerWidget(maxSize, controller),
            _volumeButton(maxSize, controller),
            if (!widget.postState.isPlaying) _playModeIcon(maxSize, controller),
          ],
        );
      },
    );
  }

  Widget _videoViewerWidget(Size maxSize, PostFeedController controller) {
    return GestureDetector(
      onTap: () => controller
          .togglePlayPause(widget.postState.homeScreenPostData.postId),
      onDoubleTap: () {},
      // onDoubleTap: _handleVideoDoubleTap,
      child: SizedBox(
        width: maxSize.width,
        height: maxSize.height,
        child: widget.postState.videoController?.value.isInitialized ?? false
            ? ClipRRect(
                borderRadius: widget.contentBorderRadius,
                child: AspectRatio(
                  aspectRatio:
                      widget.postState.videoController!.value.aspectRatio,
                  child: VideoPlayer(widget.postState.videoController!),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget _volumeButton(Size maxSize, PostFeedController controller) {
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
        iconData: widget.postState.isMuted ? Icons.volume_off : Icons.volume_up,
        onTap: () {
          controller.toggleMuteAll();
        },
      ),
    );
  }

  _playModeIcon(Size maxSize, PostFeedController controller) {
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
        onTap: () => controller
            .togglePlayPause(widget.postState.homeScreenPostData.postId),
      ),
    );
  }
}

// class VideoContentViewer extends ConsumerStatefulWidget {
//   final BorderRadius contentBorderRadius;
//   final HomeScreenPostData homeScreenPostData;
//   final String url;

//   const VideoContentViewer({
//     super.key,
//     required this.contentBorderRadius,
//     required this.homeScreenPostData,
//     required this.url,
//   });

//   @override
//   VideoContentViewerState createState() => VideoContentViewerState();
// }

// class VideoContentViewerState extends ConsumerState<VideoContentViewer> {
//   late VideoPlayerController controller;
//   bool _isInPlayMode = true;

//   @override
//   void initState() {
//     super.initState();
//     // bool isMuted = ref.read(muteStateProvider);
//     controller = VideoPlayerController.networkUrl(
//       Uri.parse(widget.url),
//     )..initialize().then(
//         (value) {
//           setState(() {
//             controller.setLooping(true);
//             // controller.setVolume(isMuted ? 0.0 : 1.0);
//             controller.play();
//           });
//         },
//       );
//   }

//   void _handleVideoTap() {
//     setState(() {
//       _isInPlayMode = !_isInPlayMode;
//     });
//     if (_isInPlayMode) {
//       controller.play();
//     } else {
//       controller.pause();
//     }
//   }

//   void _handleVideoDoubleTap() {
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //     builder: (context) => FullScreenPost(
//     //       fullScreenMediaType: FullScreenMediaType.video,
//     //       homeScreenPostData: widget.homeScreenPostData,
//     //     ),
//     //   ),
//     // );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilderChild(
//       child: (minSize, maxSize) {
//         return Stack(
//           children: [
//             _videoViewerWidget(maxSize),
//             _volumeButton(maxSize),
//             if (!_isInPlayMode) _playModeIcon(maxSize),
//           ],
//         );
//       },
//     );
//   }

//   Widget _videoViewerWidget(Size maxSize) {
//     return GestureDetector(
//       onTap: _handleVideoTap,
//       onDoubleTap: _handleVideoDoubleTap,
//       child: SizedBox(
//         width: maxSize.width,
//         height: maxSize.height,
//         child: controller.value.isInitialized
//             ? ClipRRect(
//                 borderRadius: widget.contentBorderRadius,
//                 child: AspectRatio(
//                   aspectRatio: controller.value.aspectRatio,
//                   child: VideoPlayer(controller),
//                 ),
//               )
//             : const Center(
//                 child: CircularProgressIndicator(),
//               ),
//       ),
//     );
//   }

//   Widget _volumeButton(Size maxSize) {
//     double minDimension = maxSize.shortestSide;
//     double buttonSize = minDimension * 0.1;
//     // bool isMuted = ref.watch(muteStateProvider);
//     bool isMuted = true;
//     return Positioned(
//       bottom: minDimension * 0.05,
//       right: minDimension * 0.05,
//       child: LinkWinIcon(
//         iconSize: Size(buttonSize, buttonSize),
//         splashColor: transparent,
//         backgroundColor: k1Gray.withOpacity(0.75),
//         iconColor: kWhite,
//         iconSizeRatio: 0.7,
//         iconData: isMuted ? Icons.volume_off : Icons.volume_up,
//         onTap: () {
//           // setState(() {
//           //   ref.read(muteStateProvider.notifier).state = !isMuted;
//           //   controller.setVolume(isMuted ? 0.0 : 1.0);
//           // });
//         },
//       ),
//     );
//   }

//   _playModeIcon(Size maxSize) {
//     double iconSize = maxSize.width * 0.15;
//     double iconContainerSize = iconSize * 1.1;
//     return Center(
//       child: LinkWinIcon(
//         iconSize: Size(iconContainerSize, iconContainerSize),
//         splashColor: transparent,
//         backgroundColor: k1Gray.withOpacity(0.75),
//         iconColor: kWhite,
//         iconSizeRatio: iconSize / iconContainerSize,
//         iconData: Icons.play_arrow,
//         onTap: _handleVideoTap,
//       ),
//     );
//   }
// }
