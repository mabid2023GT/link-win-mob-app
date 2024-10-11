import 'package:link_win_mob_app/core/services/constants/feed_post_actions_constants.dart';

class FeedPostActionDetails {
  final String actionId;
  final String ownerId;
  final DateTime createdAt;

  FeedPostActionDetails({
    required this.actionId,
    required this.ownerId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      ownerAttr: ownerId,
      createdAtAttr: createdAt,
    };
  }

  factory FeedPostActionDetails.fromMap(
      String actionId, Map<String, dynamic> map) {
    return FeedPostActionDetails(
      actionId: actionId,
      ownerId: map[ownerAttr],
      createdAt: map[createdAtAttr],
    );
  }
}

class FeedPostCommentDetails extends FeedPostActionDetails {
  final String comment;

  FeedPostCommentDetails({
    required super.actionId,
    required super.ownerId,
    required super.createdAt,
    required this.comment,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ownerAttr: ownerId,
      commentAttr: comment,
      createdAtAttr: createdAt,
    };
  }

  factory FeedPostCommentDetails.fromMap(
      String actionId, Map<String, dynamic> map) {
    return FeedPostCommentDetails(
      actionId: actionId,
      ownerId: map[ownerAttr],
      comment: map[commentAttr],
      createdAt: map[createdAtAttr],
    );
  }
}

class FeedPostReviewDetails extends FeedPostActionDetails {
  final String comment;
  final int rating; // values from 1 to 5

  FeedPostReviewDetails({
    required super.actionId,
    required super.ownerId,
    required super.createdAt,
    required this.comment,
    required this.rating,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ownerAttr: ownerId,
      commentAttr: comment,
      ratingAttr: rating,
      createdAtAttr: createdAt,
    };
  }

  factory FeedPostReviewDetails.fromMap(
      String actionId, Map<String, dynamic> map) {
    return FeedPostReviewDetails(
      actionId: actionId,
      ownerId: map[ownerAttr],
      comment: map[commentAttr],
      rating: map[ratingAttr],
      createdAt: map[createdAtAttr],
    );
  }
}
