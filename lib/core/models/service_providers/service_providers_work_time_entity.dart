enum ServiceProvidersWorkTimeEntityConstants {
  day,
  startTime,
  endTime,
  isVacation
}

class ServiceProvidersWorkTimeEntity {
  final String day;
  final String startTime;
  final String endTime;
  final bool isVacation;

  ServiceProvidersWorkTimeEntity({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.isVacation,
  });

  // CopyWith method to create a copy with updated fields
  ServiceProvidersWorkTimeEntity copyWith({
    String? day,
    String? startTime,
    String? endTime,
    bool? isVacation,
  }) {
    return ServiceProvidersWorkTimeEntity(
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isVacation: isVacation ?? this.isVacation,
    );
  }

  // From Firestore method (deserialize)
  factory ServiceProvidersWorkTimeEntity.fromMap(Map<String, dynamic> data) {
    return ServiceProvidersWorkTimeEntity(
      day: data[ServiceProvidersWorkTimeEntityConstants.day.name],
      startTime:
          data[ServiceProvidersWorkTimeEntityConstants.startTime.name] ?? '',
      endTime: data[ServiceProvidersWorkTimeEntityConstants.endTime.name] ?? '',
      isVacation:
          data[ServiceProvidersWorkTimeEntityConstants.isVacation.name] ??
              false,
    );
  }

  // ToMap method (serialize)
  Map<String, dynamic> toMap() {
    return {
      ServiceProvidersWorkTimeEntityConstants.day.name: day,
      ServiceProvidersWorkTimeEntityConstants.startTime.name: startTime,
      ServiceProvidersWorkTimeEntityConstants.endTime.name: endTime,
      ServiceProvidersWorkTimeEntityConstants.isVacation.name: isVacation,
    };
  }

  String displayTime() {
    String res = '';
    if (isVacation) return 'Vacation';
    res = '$startTime - $endTime';
    return res;
  }
}
