class ServiceProvidersAppointmentModel {
  final String providerName;
  final String category;
  final String date;
  final String time;
  final bool isCompleted;
  final int rating;

  ServiceProvidersAppointmentModel({
    required this.providerName,
    required this.category,
    required this.date,
    required this.time,
    required this.isCompleted,
    required this.rating,
  });

  ServiceProvidersAppointmentModel copyWith({
    String? providerName,
    String? category,
    String? date,
    String? time,
    bool? isCompleted,
    int? rating,
  }) {
    return ServiceProvidersAppointmentModel(
      providerName: providerName ?? this.providerName,
      category: category ?? this.category,
      date: date ?? this.date,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      rating: rating ?? this.rating,
    );
  }
}
