// Simulate fetching sponsored ads (local data for now)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/feed_sponsored_ads_data.dart';

final feedSponsoredAdsProvider = Provider<List<FeedSponsoredAdsData>>((ref) {
  return [
    FeedSponsoredAdsData(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOynW9s4uM573HczHEmLruatZlAeA65_vOQg&s',
    ),
    FeedSponsoredAdsData(
      imageUrl:
          'https://marketplace.canva.com/EAE30i-WQEs/1/0/1600w/canva-yellow-modern-construction-flyer-landscape-VxDgAf7TqUk.jpg',
    ),
    FeedSponsoredAdsData(
      imageUrl:
          'https://media.istockphoto.com/id/1398693404/photo/beautiful-kitchen-in-new-luxury-home-with-island-pendant-lights-and-hardwood-floors.jpg?s=612x612&w=0&k=20&c=Q44P-Jy5nbhTY1sUrrnpSPep3UsORVYDL7Ud4jLBbHA=',
    ),
    FeedSponsoredAdsData(
      imageUrl:
          'https://s.tmimgcdn.com/scr/1200x750/190700/delicious-food-billboard-landscape_190771-original.jpg',
    ),
    FeedSponsoredAdsData(
      imageUrl: 'https://st.hzcdn.com/simgs/6061b21b08dce6ca_14-0210/_.jpg',
    ),
    FeedSponsoredAdsData(
      imageUrl:
          'https://img.freepik.com/free-psd/food-menu-restaurant-web-banner-template_106176-1459.jpg',
    ),
    FeedSponsoredAdsData(
      imageUrl:
          'https://img.freepik.com/premium-vector/lawn-gardening-service-social-media-post-design-agriculture-farming-business-advertisement-flyer-vector-lawn-mower-harvesting-work-service-discount-social-media-banner-template_538213-485.jpg',
    ),
    FeedSponsoredAdsData(
      imageUrl:
          'https://t3.ftcdn.net/jpg/06/26/79/52/360_F_626795218_9wiEkgiCUz9uI6NGgtI2EGmc6Cy0SxaY.jpg',
    ),
  ];
});

// class FeedSponsoredAdsProvider {}
