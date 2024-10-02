import 'package:link_win_mob_app/core/models/feed/feed_post_profile_details.dart';
import 'package:link_win_mob_app/core/utils/enums/feed_post_type.dart';

class FeedPostData {
  final FeedPostType feedPostType;
  final List<String> content;
  final String postId;
  final int pageIndex;
  final Map<FeedPostActions, FeedPostActionData> actionsData;
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
    Map<FeedPostActions, FeedPostActionData>? actionsData,
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

  FeedPostActionData? fetchActionsData({
    required FeedPostActions action,
  }) {
    return actionsData[action];
  }

  void updateActionsData({
    required FeedPostActions action,
    required int value,
  }) {
    FeedPostActionData? temp = actionsData[action];
    if (temp != null) {
      temp.copyWith(value: value);
    }
  }
}

class FeedPostActionData {
  final FeedPostActions action;
  final String value;
  final bool isClicked;

  FeedPostActionData({
    required this.action,
    required int value,
    required this.isClicked,
  }) : value = valueAsString(value);

  FeedPostActionData copyWith({
    FeedPostActions? action,
    int? value,
    bool? isClicked,
  }) {
    return FeedPostActionData(
      action: action ?? this.action,
      value: value ?? _valueAsInt(),
      isClicked: isClicked ?? this.isClicked,
    );
  }

  // Method to convert an integer to a formatted string
  static String valueAsString(int val) {
    if (val < 1000) {
      return val.toString(); // Less than 1000, return as is
    } else if (val < 1000000) {
      return '${(val / 1000).toStringAsFixed(0)}k'; // Thousands
    } else if (val < 1000000000) {
      return '${(val / 1000000).toStringAsFixed(0)}M'; // Millions
    } else {
      return '${(val / 1000000000).toStringAsFixed(0)}B'; // Billions
    }
  }
  // static String valueAsString(int val) {
  //   if (val < 1000) {
  //     return val.toString(); // Less than 1000, return as is
  //   } else if (val < 100000) {
  //     return '${(val / 1000).toStringAsFixed(0)} k'; // Thousands
  //   } else {
  //     return '${(val / 1000).toStringAsFixed(0)} k'; // Hundreds of thousands
  //   }
  // }

  // Method to convert formatted string back to an integer
  int _valueAsInt() {
    if (value.endsWith('k')) {
      String numberPart = value.substring(0, value.length - 1).trim();
      return ((double.tryParse(numberPart) ?? 0) * 1000)
          .toInt(); // Convert k to integer
    }
    return int.tryParse(value) ?? 0; // Convert regular number to integer
  }

  int updateValue() {
    int currentValue = _valueAsInt();
    int updatedValue = currentValue + (isClicked ? -1 : 1);
    return updatedValue;
  }
}
