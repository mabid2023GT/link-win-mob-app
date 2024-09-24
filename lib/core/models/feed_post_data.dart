import 'package:link_win_mob_app/core/models/feed_post_profile_details.dart';
import 'package:link_win_mob_app/core/utils/enums/feed_post_type.dart';

class FeedPostData {
  final FeedPostType feedPostType;
  final List<String> content;
  final String postId;
  final int pageIndex;
  final Map<FeedPostActions, String> actionsData;
  final FeedPostProfileDetails feedPostProfileDetails;
  final DateTime postedAt;
  late final int length;

  FeedPostData({
    required this.feedPostType,
    required this.content,
    required this.postId,
    required this.pageIndex,
    required this.actionsData,
    required this.feedPostProfileDetails,
    required this.postedAt,
  }) {
    length = content.length;
  }

  FeedPostData copyWith({
    FeedPostType? feedPostType,
    List<String>? content,
    String? postId,
    int? pageIndex,
    Map<FeedPostActions, String>? actionsData,
    FeedPostProfileDetails? feedPostProfileDetails,
    DateTime? postedAt,
  }) {
    return FeedPostData(
      feedPostType: feedPostType ?? this.feedPostType,
      content: content ?? this.content,
      postId: postId ?? this.postId,
      pageIndex: pageIndex ?? this.pageIndex,
      actionsData: actionsData ?? this.actionsData,
      feedPostProfileDetails:
          feedPostProfileDetails ?? this.feedPostProfileDetails,
      postedAt: postedAt ?? this.postedAt,
    );
  }

  String fetchActionsData({
    required FeedPostActions action,
  }) {
    return actionsData[action] ?? '';
  }

  void updateActionsData({
    required FeedPostActions action,
    required String value,
  }) {
    actionsData[action] = value;
  }
}
