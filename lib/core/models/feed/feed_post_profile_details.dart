import 'package:link_win_mob_app/core/services/constants/feed_post_constants.dart';

class FeedPostProfileDetails {
  final String profileName;
  final String profileImgUrl;

  FeedPostProfileDetails({
    required this.profileName,
    required this.profileImgUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      profileNameAttr: profileName,
      profileImgUrlAttr: profileImgUrl,
    };
  }

  factory FeedPostProfileDetails.fromMap(Map<String, dynamic> map) {
    return FeedPostProfileDetails(
      profileName: map[profileNameAttr],
      profileImgUrl: map[profileImgUrlAttr],
    );
  }
}
