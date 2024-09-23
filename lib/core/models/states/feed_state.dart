import 'package:link_win_mob_app/core/models/feed_post_data.dart';

class FeedState {
  final List<FeedPostData> posts;
  final bool isMuted;

  FeedState({
    required this.posts,
    required this.isMuted,
  });

  FeedState copyWith({
    List<FeedPostData>? posts,
    bool? isMuted,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
      isMuted: isMuted ?? this.isMuted,
    );
  }
}
