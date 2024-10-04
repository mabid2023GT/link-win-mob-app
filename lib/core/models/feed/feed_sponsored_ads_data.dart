import 'package:link_win_mob_app/core/services/constants/feed_sponsored_constants.dart';

class FeedSponsoredAdsData {
  final String ownerId;
  final String imageUrl;

  FeedSponsoredAdsData({
    required this.ownerId,
    required this.imageUrl,
  });

  FeedSponsoredAdsData copyWith({
    String? imageUrl,
    String? ownerId,
  }) {
    return FeedSponsoredAdsData(
      imageUrl: imageUrl ?? this.imageUrl,
      ownerId: ownerId ?? this.ownerId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      imageUrlAttr: imageUrl,
    };
  }

  factory FeedSponsoredAdsData.fromMap(
      String ownerId, Map<String, dynamic> map) {
    return FeedSponsoredAdsData(
      ownerId: ownerId,
      imageUrl: map[imageUrlAttr],
    );
  }
}
