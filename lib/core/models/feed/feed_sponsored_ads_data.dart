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
}
