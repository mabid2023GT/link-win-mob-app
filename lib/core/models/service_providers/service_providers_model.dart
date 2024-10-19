class ServiceProvidersModel {
  final String displayName;
  final double rating;
  final String coverPhotoPath;
  final bool isCurrentlyAvailable;
  final Map<String, String> workTime;

  ServiceProvidersModel({
    required this.displayName,
    required this.rating,
    required this.coverPhotoPath,
    this.workTime = const {},
    this.isCurrentlyAvailable = false,
  });

  ServiceProvidersModel copyWith({
    String? displayName,
    double? rating,
    String? coverPhotoPath,
    bool? isCurrentlyAvailable,
    Map<String, String>? workTime,
  }) {
    if (workTime != null && workTime.isNotEmpty) {
      workTime.forEach(
        (day, time) {
          this.workTime[day] = time;
        },
      );
    }
    return ServiceProvidersModel(
      displayName: displayName ?? this.displayName,
      rating: rating ?? this.rating,
      coverPhotoPath: coverPhotoPath ?? this.coverPhotoPath,
      isCurrentlyAvailable: isCurrentlyAvailable ?? this.isCurrentlyAvailable,
      workTime: this.workTime,
    );
  }
}
