import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_model.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_virtual_assistance_query.dart';

final serviceProvidersVirtualAssistanceResultsProvider = StateNotifierProvider<
    ServiceProvidersVirtualAssistanceResultsNotifier,
    Map<String, ServiceProvidersVirtualAssistanceQuery>>(
  (ref) => ServiceProvidersVirtualAssistanceResultsNotifier(),
);

class ServiceProvidersVirtualAssistanceResultsNotifier
    extends StateNotifier<Map<String, ServiceProvidersVirtualAssistanceQuery>> {
  ServiceProvidersVirtualAssistanceResultsNotifier()
      : super(_initialServiceProvidersVirtualAssistanceResultsData());

  Future<void> stopQuery(String queryId) async {
    // Get the query from the state using the queryId
    final query = state[queryId];
    if (query != null && query.isQueryActive) {
      // Update the query to mark it as inactive
      final updatedQuery = query.copyWith(isQueryActive: false);
      // Update the state with the modified query
      state = {
        ...state,
        queryId: updatedQuery,
      };
    }
  }
}

Map<String, ServiceProvidersVirtualAssistanceQuery>
    _initialServiceProvidersVirtualAssistanceResultsData() {
  return {
    'query1x4': ServiceProvidersVirtualAssistanceQuery(
      queryId: 'query1x4',
      category: 'Plumbing',
      isScheduled: false,
      budget: '100\$ - 250\$',
      showRatingsAndReviews: true,
      location: 'Haifa District',
      isQueryActive: false,
      queryResult: [
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
          displayName: 'Plumber Hero',
          rating: 5,
          coverPhotoPath: '',
        )
      ],
    ),
    'query5z1': ServiceProvidersVirtualAssistanceQuery(
      queryId: 'query5z1',
      category: 'Electrical Work',
      isScheduled: true,
      budget: '300\$ - 500\$',
      showRatingsAndReviews: true,
      location: 'Tel-Aviv',
      isQueryActive: false,
      queryResult: [
        ServiceProvidersModel(
          displayName: 'Electrico',
          rating: 4.8,
          coverPhotoPath:
              'https://i0.wp.com/rbtautomate.com/wp-content/uploads/2023/02/Benefits-of-Commercial-Electrical-Services-for-Businesses--scaled.jpg?fit=2560%2C1707&ssl=1',
        ),
        ServiceProvidersModel(
          displayName: 'Top Electric',
          rating: 4.9,
          coverPhotoPath:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEoq0MdUuaZhEOGtja_OI3ed-h9i3M6INv2g&s',
        ),
      ],
    ),
    'query2J3': ServiceProvidersVirtualAssistanceQuery(
      queryId: 'query2J3',
      category: 'Moving Services',
      isScheduled: true,
      budget: '500\$ +',
      showRatingsAndReviews: false,
      location: 'Accre District',
      queryResult: [],
      isQueryActive: true,
    ),
    'query9t5': ServiceProvidersVirtualAssistanceQuery(
      queryId: 'query9t5',
      category: 'Carpentry',
      isScheduled: false,
      budget: '300\$ +',
      showRatingsAndReviews: true,
      location: 'Nabuls',
      isQueryActive: true,
      queryResult: [
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
    ),
  };
}
