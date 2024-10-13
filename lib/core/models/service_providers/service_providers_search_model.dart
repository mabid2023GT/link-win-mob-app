class ServiceProvidersSearchQuery {
  final Map<String, List<String>> queryCriteriaMap;
  final Map<String, String> userResponsesMap;

  ServiceProvidersSearchQuery({
    required this.queryCriteriaMap,
  }) : userResponsesMap = {
          for (var query in queryCriteriaMap.keys) query: '',
        };

  // Named constructor
  ServiceProvidersSearchQuery.withResponses({
    required this.queryCriteriaMap,
    required this.userResponsesMap,
  });

  int get length => queryCriteriaMap.length;

  List<MapEntry<String, List<String>>> queryCriteriaMapAsList() =>
      queryCriteriaMap.entries.toList();

  List<String> getOptions(String query) => queryCriteriaMap[query] ?? [];

  ServiceProvidersSearchQuery updateUserResponse(
      String query, String selectedOption) {
    final updatedResponses = {
      ...userResponsesMap,
      query: selectedOption,
    };
    return ServiceProvidersSearchQuery.withResponses(
      queryCriteriaMap: queryCriteriaMap,
      userResponsesMap: updatedResponses,
    );
  }
}
