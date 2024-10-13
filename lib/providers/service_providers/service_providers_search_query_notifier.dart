import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_search_model.dart';

final serviceProvidersSearchQueryProvider = StateNotifierProvider<
    ServiceProvidersSearchQueryNotifier, ServiceProvidersSearchQuery>(
  (ref) => ServiceProvidersSearchQueryNotifier(),
);

class ServiceProvidersSearchQueryNotifier
    extends StateNotifier<ServiceProvidersSearchQuery> {
  ServiceProvidersSearchQueryNotifier()
      : super(
          ServiceProvidersSearchQuery(
            queryCriteriaMap: _initQueryCriteria(),
          ),
        );

  // Method to update user responses
  void updateUserResponse(String query, String selectedOption) {
    state = state.updateUserResponse(query, selectedOption);
  }

  // Method to initialize the questions and options
  static Map<String, List<String>> _initQueryCriteria() {
    return {
      'What type of service are you looking for?': [
        'Plumbing',
        'Electrical Work',
        'Carpentry',
        'House Cleaning',
        'Gardening/Landscaping',
        'Moving Services',
        'Appliance Repair',
        'Painting & Decorating',
        'Handyman Services',
      ],
      'When do you need this service?': ['Immediately', 'Scheduled'],
      'What’s your budget for this service?': [
        'Under \$100',
        '\$100 – \$200',
        '\$200 – \$500',
        '\$500+'
      ],
      'Would you like to see reviews or ratings of service providers?': [
        'Yes',
        'No'
      ],
      'Where do you need the service?': [
        'Haifa District',
        'Acre District',
        'Tel-Aviv',
        'Jerusalem',
        'Eilat',
        'Wadi Ara',
        'Nazareth',
        'Ashkelon',
        'Beer Sheba',
        'Tiberias',
        'Jenin',
        'Hebron',
        'Nablus',
        'Jericho',
      ],
    };
  }
}
