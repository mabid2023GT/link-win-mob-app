import 'package:link_win_mob_app/core/models/service_providers/service_providers_model.dart';

/// A class representing a query for finding service providers for virtual assistance.
///
/// This query filters service providers based on multiple criteria such as service
/// type, scheduling, budget, location, and whether ratings and reviews should be shown.
class ServiceProvidersVirtualAssistanceQuery {
  /// The unique identifier for the query.
  final String queryId;

  /// The type or category of the service (e.g., IT support, customer service).
  final String category;

  /// If `true`, it means the service is scheduled in advance.
  /// If `false`, it indicates the service is immediate (within 24 hours).
  final bool isScheduled;

  /// The budget range for the service.
  final String budget;

  /// If `true`, ratings and reviews will be included in the results.
  /// If `false`, they will be excluded.
  final bool showRatingsAndReviews;

  /// The location where the service is needed.
  final String location;

  /// The list of service providers returned by the query.
  final List<ServiceProvidersModel> queryResult;

  /// If `true`, the query is currently active.
  /// If `false`, the query is inactive or completed.
  final bool isQueryActive;

  /// Creates a [ServiceProvidersVirtualAssistanceQuery] with the given parameters.
  ///
  /// * [queryId] - The unique identifier for the query (required).
  /// * [category] - The type of service (required).
  /// * [isScheduled] - If the service is scheduled or immediate (required).
  /// * [budget] - The budget range for the service (required).
  /// * [showRatingsAndReviews] - Whether to include ratings and reviews (required).
  /// * [location] - The location where the service is required (required).
  /// * [queryResult] - The list of service providers returned by the query (required).
  /// * [isQueryActive] - Whether the query is currently active or not (required).
  ServiceProvidersVirtualAssistanceQuery({
    required this.queryId,
    required this.category,
    required this.isScheduled,
    required this.budget,
    required this.showRatingsAndReviews,
    required this.location,
    required this.queryResult,
    required this.isQueryActive,
  });

  /// Returns a new instance of [ServiceProvidersVirtualAssistanceQuery] with the
  /// option to modify any of the fields while preserving the existing ones.
  ///
  /// * [queryId] - The new query identifier (optional).
  /// * [category] - The new service category (optional).
  /// * [isScheduled] - The new scheduling type (optional).
  /// * [budget] - The new budget range (optional).
  /// * [showRatingsAndReviews] - The new value for showing ratings and reviews (optional).
  /// * [location] - The new location (optional).
  /// * [queryResult] - The updated list of service providers (optional).
  /// * [isQueryActive] - The new active state of the query (optional).
  ServiceProvidersVirtualAssistanceQuery copyWith({
    String? queryId,
    String? category,
    bool? isScheduled,
    String? budget,
    bool? showRatingsAndReviews,
    String? location,
    List<ServiceProvidersModel>? queryResult,
    bool? isQueryActive,
  }) {
    return ServiceProvidersVirtualAssistanceQuery(
      category: category ?? this.category,
      isScheduled: isScheduled ?? this.isScheduled,
      budget: budget ?? this.budget,
      showRatingsAndReviews:
          showRatingsAndReviews ?? this.showRatingsAndReviews,
      location: location ?? this.location,
      queryResult: queryResult ?? this.queryResult,
      queryId: queryId ?? this.queryId,
      isQueryActive: isQueryActive ?? this.isQueryActive,
    );
  }
}
