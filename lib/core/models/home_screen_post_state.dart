import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/home_screen_post_type.dart';
import 'package:video_player/video_player.dart';

class HomeScreenPostState {
  final HomeScreenPostData homeScreenPostData;
  final bool isMuted;
  final bool isPlaying;
  // range 0 to 1
  final double volume;
  // In seconds, for video tracking.
  final double currentTime;
  // Add video controller here
  final VideoPlayerController? videoController;

  HomeScreenPostState({
    required this.homeScreenPostData,
    this.isMuted = true,
    this.isPlaying = false,
    this.volume = 0.0,
    this.currentTime = 0.0,
    this.videoController,
  });

  // Helper to check if this post is a video post
  bool get isVideoPost =>
      homeScreenPostData.homeScreenPostType == HomeScreenPostType.video ||
      homeScreenPostData.homeScreenPostType ==
          HomeScreenPostType.videoCollection;

  HomeScreenPostState copyWith({
    bool? isMuted,
    bool? isPlaying,
    double? volume,
    double? currentTime,
    VideoPlayerController? videoController,
  }) {
    return HomeScreenPostState(
      homeScreenPostData: homeScreenPostData,
      currentTime: currentTime ?? this.currentTime,
      isMuted: isMuted ?? this.isMuted,
      isPlaying: isPlaying ?? this.isPlaying,
      volume: volume ?? this.volume,
      videoController: videoController ?? this.videoController,
    );
  }
}
