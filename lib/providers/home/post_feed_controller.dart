import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_state.dart';
import 'package:video_player/video_player.dart';

class PostFeedController extends StateNotifier<List<HomeScreenPostState>> {
  PostFeedController(List<HomeScreenPostData> posts)
      : super(posts
            .map((post) => HomeScreenPostState(homeScreenPostData: post))
            .toList());

  // Initialize video controller for a specific post
  void initializeVideoController(String postId, String videoUrl) {
    state = [
      for (final post in state)
        if (post.homeScreenPostData.postId == postId)
          post.copyWith(
              videoController:
                  VideoPlayerController.networkUrl(Uri.parse(videoUrl))
                    ..initialize())
        else
          post
    ];
  }

  // Toggles mute state for all video posts
  void toggleMuteAll() {
    final isAllMuted = state.every((postState) => postState.isMuted);
    state = [
      for (final post in state)
        if (post.isVideoPost) post.copyWith(isMuted: !isAllMuted) else post
    ];

    // Handle volume changes asynchronously for each video post
    for (final post in state) {
      if (post.isVideoPost) {
        post.videoController?.setVolume(isAllMuted ? 1.0 : 0.0);
      }
    }
  }

  // Toggles play/pause for a single post on the ID
  void togglePlayPause(String postId) {
    state = [
      for (final post in state)
        if (post.homeScreenPostData.postId == postId && post.isVideoPost)
          post.copyWith(isPlaying: !post.isPlaying)
        else
          post
    ];

    final postState =
        state.firstWhere((post) => post.homeScreenPostData.postId == postId);
    if (postState.isPlaying) {
      postState.videoController?.play();
    } else {
      postState.videoController?.pause();
    }
  }

  // Dispose video controller for a specific post
  void disposeVideoController(String postId) {
    final postState =
        state.firstWhere((post) => post.homeScreenPostData.postId == postId);
    postState.videoController?.dispose();
    state = [
      for (final post in state)
        if (post.homeScreenPostData.postId == postId)
          post.copyWith(videoController: null)
        else
          post
    ];
  }

  // Set volume for all videos
  void setVolumeForAll(double volume) {
    state = [
      for (final post in state)
        if (post.isVideoPost) post.copyWith(volume: volume) else post
    ];

    // Handle volume changes asynchronously for each video post
    for (final post in state) {
      if (post.isVideoPost) {
        post.videoController?.setVolume(volume);
      }
    }
  }

  // Rewind video 10 seconds
  void rewindVideo({
    required String postId,
    int seconds = 10,
  }) {
    // Update the state synchronously (decrease the current time)
    final updateState = [
      for (final post in state)
        if (post.homeScreenPostData.postId == postId && post.isVideoPost)
          post.copyWith(currentTime: post.currentTime - seconds)
        else
          post
    ];
    state = updateState;

    // Handle seeking asynchronously
    final postToRewind =
        state.firstWhere((post) => post.homeScreenPostData.postId == postId);
    if (postToRewind.videoController != null) {
      final newTime =
          Duration(seconds: (postToRewind.currentTime - seconds).toInt());
      postToRewind.videoController?.seekTo(newTime);
    }
  }

  // Fast forward video 10 seconds
  void forwardVideo({
    required String postId,
    int seconds = 10,
  }) {
    // Update the state synchronously (increase the current time)
    final updateState = [
      for (final post in state)
        if (post.homeScreenPostData.postId == postId && post.isVideoPost)
          post.copyWith(currentTime: post.currentTime + seconds)
        else
          post
    ];
    state = updateState;

    // Handle seeking asynchronously
    final postToForward =
        state.firstWhere((post) => post.homeScreenPostData.postId == postId);
    if (postToForward.videoController != null) {
      final newTime =
          Duration(seconds: (postToForward.currentTime + seconds).toInt());
      postToForward.videoController?.seekTo(newTime);
    }
  }
}
