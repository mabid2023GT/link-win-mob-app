import 'package:link_win_mob_app/core/utils/enums/home_screen_post_type.dart';

class HomeScreenPostData {
  final HomeScreenPostType homeScreenPostType;
  final List<String> content;
  final String postId;
  final Map<HomeScreenPostActions, String> actionsData;

  HomeScreenPostData({
    required this.homeScreenPostType,
    required this.content,
    required this.postId,
    required this.actionsData,
  });

  String fetchActionsData({
    required HomeScreenPostActions action,
  }) {
    return actionsData[action] ?? '';
  }
}
