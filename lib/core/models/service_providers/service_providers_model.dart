import 'package:link_win_mob_app/core/services/constants/service_providers_constants.dart';

class TimeRange {
  final String start;
  final String end;

  TimeRange({
    required this.start,
    required this.end,
  });

  @override
  String toString() {
    return '$start - $end';
  }

  // Convert TimeRange to a map
  Map<String, String> toMap() {
    return {
      startTimeAttr: start,
      endTimeAttr: end,
    };
  }

  factory TimeRange.fromMap(Map<String, dynamic> map) {
    return TimeRange(
      start: map[startTimeAttr],
      end: map[endTimeAttr],
    );
  }
}

class ServiceProvidersModel {
  final String serviceId;
  final String userId;
  String phoneNumber;
  String email;
  String description;
  final String serviceCategory;
  Map<String, List<TimeRange>> hoursWork;

  ServiceProvidersModel({
    required this.serviceId,
    required this.userId,
    required this.phoneNumber,
    required this.email,
    required this.description,
    required this.serviceCategory,
    required this.hoursWork,
  });

  ServiceProvidersModel copyWith({
    String? serviceId,
    String? userId,
    String? phoneNumber,
    String? email,
    String? description,
    String? serviceCategory,
    Map<String, List<TimeRange>>? hoursWork,
  }) {
    return ServiceProvidersModel(
      serviceId: serviceId ?? '',
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      description: description ?? this.description,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      hoursWork: hoursWork ?? this.hoursWork,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, List<Map<String, String>>> mappedHoursWork = {};
    hoursWork.forEach((day, timeRanges) {
      mappedHoursWork[day] =
          timeRanges.map((timeRange) => timeRange.toMap()).toList();
    });

    return {
      userIdAttr: userId,
      phoneAttr: phoneNumber,
      emailAttr: email,
      descriptionAttr: description,
      serviceCategoryAttr: serviceCategory,
      hoursWorkAttr: mappedHoursWork,
    };
  }

  factory ServiceProvidersModel.fromMap(
      String serviceId, Map<String, dynamic> map) {
    Map<String, List<TimeRange>> hoursWork = {};
    (map[hoursWorkAttr] as Map<String, dynamic>).forEach((day, times) {
      hoursWork[day] = (times as List<dynamic>)
          .map(
              (timeData) => TimeRange.fromMap(timeData as Map<String, dynamic>))
          .toList();
    });

    return ServiceProvidersModel(
      serviceId: serviceId,
      userId: map[userIdAttr],
      phoneNumber: map[phoneAttr],
      email: map[emailAttr],
      description: map[descriptionAttr],
      serviceCategory: map[serviceCategoryAttr],
      hoursWork: hoursWork,
    );
  }
}
