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
}
