import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_appointment_model.dart';

final serviceProvidersSearchAppointmentsProvider = StateNotifierProvider<
    ServiceProvidersSearchAppointmentsNotifier,
    List<ServiceProvidersAppointmentModel>>(
  (ref) => ServiceProvidersSearchAppointmentsNotifier(),
);

class ServiceProvidersSearchAppointmentsNotifier
    extends StateNotifier<List<ServiceProvidersAppointmentModel>> {
  ServiceProvidersSearchAppointmentsNotifier()
      : super(_initialAppointmentsData());

  // Method to update the isCompleted status of an appointment
  void updateIsCompletedStatus(int index, bool isCompleted) {
    // Create a copy of the current state
    final updatedAppointments = [...state];
    // Update the isCompleted status of the specified appointment
    updatedAppointments[index] = updatedAppointments[index].copyWith(
      isCompleted: isCompleted,
    );
    // Update the state with the modified list
    state = updatedAppointments;
  }
}

List<ServiceProvidersAppointmentModel> _initialAppointmentsData() {
  return [
    ServiceProvidersAppointmentModel(
      providerName: 'Ali Krabo',
      category: 'Plumbing',
      date: '18/10/2024',
      time: '14:00',
      isCompleted: false,
      rating: 0,
    ),
    ServiceProvidersAppointmentModel(
      providerName: 'Hado Krum',
      category: 'House Cleaning',
      date: '28/10/2024',
      time: '10:00',
      isCompleted: true,
      rating: 0,
    ),
    ServiceProvidersAppointmentModel(
      providerName: 'David Krite',
      category: 'Electrical Work',
      date: '22/10/2024',
      time: '12:30',
      isCompleted: false,
      rating: 0,
    ),
  ];
}
