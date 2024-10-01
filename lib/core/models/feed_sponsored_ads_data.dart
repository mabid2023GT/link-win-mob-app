class FeedSponsoredAdsData {
  final String imageUrl;

  FeedSponsoredAdsData({required this.imageUrl});

  FeedSponsoredAdsData copyWith({String? imageUrl}) {
    return FeedSponsoredAdsData(imageUrl: imageUrl ?? this.imageUrl);
  }
}
