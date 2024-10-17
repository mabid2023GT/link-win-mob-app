import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_model.dart';

final topRatedServiceProvidersProvider = StateNotifierProvider<
    TopRatedServiceProvidersNotifier, Map<String, List<ServiceProvidersModel>>>(
  (ref) => TopRatedServiceProvidersNotifier(),
);

class TopRatedServiceProvidersNotifier
    extends StateNotifier<Map<String, List<ServiceProvidersModel>>> {
  TopRatedServiceProvidersNotifier() : super(_initialTopRatedProvidersData());
}

Map<String, List<ServiceProvidersModel>> _initialTopRatedProvidersData() {
  return {
    'Plumbing Services': [
      ServiceProvidersModel(
        displayName: 'Plumbo',
        rating: 4.5,
        coverPhotoPath:
            'https://www.emuplumbing.com.au/wp-content/uploads/shutterstock_1452207740-scaled.jpg',
      ),
      ServiceProvidersModel(
        displayName: 'Top Plumber',
        rating: 5,
        coverPhotoPath:
            'https://maintenanceindubai.ae/wp-content/uploads/2022/12/Plumber-vs-DIY.jpeg',
      ),
      ServiceProvidersModel(
        displayName: 'Plumber Pro',
        rating: 5,
        coverPhotoPath:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzxmmnJAeUbx2bbbYdzQk9_fnokE8iIJNTOA&s',
      ),
      ServiceProvidersModel(
        displayName: 'Plumbero X3',
        rating: 4.1,
        coverPhotoPath:
            'https://www.valetgroups.com/service_images/19serone.jpg',
      ),
      ServiceProvidersModel(
        displayName: 'Plumber Hero',
        rating: 5,
        coverPhotoPath: '',
      )
    ],
    'Electrical Services': [
      ServiceProvidersModel(
        displayName: 'Electrico',
        rating: 4.8,
        coverPhotoPath:
            'https://i0.wp.com/rbtautomate.com/wp-content/uploads/2023/02/Benefits-of-Commercial-Electrical-Services-for-Businesses--scaled.jpg?fit=2560%2C1707&ssl=1',
      ),
      ServiceProvidersModel(
        displayName: 'Electric Pro',
        rating: 4.3,
        coverPhotoPath:
            'https://www.deltaelectric.net/wp-content/uploads/2023/02/commercial-electrician.jpg',
      ),
      ServiceProvidersModel(
        displayName: 'Top Electric',
        rating: 4.9,
        coverPhotoPath:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEoq0MdUuaZhEOGtja_OI3ed-h9i3M6INv2g&s',
      ),
    ],
    'Carpentry and Woodwork': [
      ServiceProvidersModel(
        displayName: 'Wadoly Brand',
        rating: 4.5,
        coverPhotoPath:
            'https://grainger-prod.adobecqms.net/content/dam/grainger/gus/en/public/digital-tactics/know-how/hero/SS-KH_24MustHaveWoodworkingToolsForYourWorkshop_KH-HRO.jpg',
      ),
      ServiceProvidersModel(
        displayName: 'Woody Pro',
        rating: 4.5,
        coverPhotoPath:
            'https://businessabc.net/_next/image?url=https%3A%2F%2Fztd-euwest2-prod-s3.s3.eu-west-2.amazonaws.com%2FStarting_A_Woodworking_Business_95890978e8.png&w=1920&q=75',
      ),
    ],
  };
}
