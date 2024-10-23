import 'package:link_win_mob_app/core/models/service_providers/service_providers_work_time_entity.dart';

class ServiceProvidersModel {
  final String displayName;
  final double rating;
  final String coverPhotoPath;
  final bool isCurrentlyAvailable;
  final Map<String, ServiceProvidersWorkTimeEntity> workTime;

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
    Map<String, ServiceProvidersWorkTimeEntity>? workTimeMap,
    ServiceProvidersWorkTimeEntity? workTimeEntity,
  }) {
    if (workTimeMap != null && workTimeMap.isNotEmpty) {
      workTimeMap.forEach(
        (day, time) {
          workTime[day] = time;
        },
      );
    }
    if (workTimeEntity != null) {
      workTime[workTimeEntity.day] = workTimeEntity;
    }
    return ServiceProvidersModel(
      displayName: displayName ?? this.displayName,
      rating: rating ?? this.rating,
      coverPhotoPath: coverPhotoPath ?? this.coverPhotoPath,
      isCurrentlyAvailable: isCurrentlyAvailable ?? this.isCurrentlyAvailable,
      workTime: workTime,
    );
  }
}
