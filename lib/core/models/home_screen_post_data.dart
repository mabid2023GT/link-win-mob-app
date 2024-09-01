import 'package:link_win_mob_app/core/models/home_screen_post_profile_details.dart';
import 'package:link_win_mob_app/core/utils/enums/home_screen_post_type.dart';

class HomeScreenPostData {
  final HomeScreenPostType homeScreenPostType;
  final List<String> content;
  final String postId;
  final Map<HomeScreenPostActions, String> actionsData;
  final HomeScreenPostProfileDetails homeScreenPostProfileDetails;
  final DateTime postedAt;
  late final int length;

  HomeScreenPostData({
    required this.homeScreenPostType,
    required this.content,
    required this.postId,
    required this.actionsData,
    required this.homeScreenPostProfileDetails,
    required this.postedAt,
  }) {
    length = content.length;
  }

  String fetchActionsData({
    required HomeScreenPostActions action,
  }) {
    return actionsData[action] ?? '';
  }
}
