import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_model.dart';
import 'package:link_win_mob_app/core/utils/enums/days_of_week_enum.dart';

final serviceProviderAccountProvider = StateNotifierProvider<
    ServiceProviderAccountNotifier, ServiceProvidersModel>(
  (ref) => ServiceProviderAccountNotifier(),
);

class ServiceProviderAccountNotifier
    extends StateNotifier<ServiceProvidersModel> {
  ServiceProviderAccountNotifier() : super(_initialData());

  // Method to update the cover photo
  Future<void> updateDisplayName(String newName) async {
    state = state.copyWith(displayName: newName);
  }

  // Method to update the cover photo
  Future<void> updateCoverPhoto(String newCoverPhoto) async {
    state = state.copyWith(coverPhotoPath: newCoverPhoto);
  }

  // Method to update availability status
  Future<void> updateAvailability(bool newAvailability) async {
    state = state.copyWith(isCurrentlyAvailable: newAvailability);
  }

  // Method to update work time
  Future<void> updateWorkTime(Map<String, String> newWorkTime) async {
    state = state.copyWith(workTime: newWorkTime);
  }
}

ServiceProvidersModel _initialData() {
  Map<String, String> temp = Map.fromEntries(
    DaysOfWeekExtension.toList().map(
      (day) => MapEntry(day.name, '14:50 - 18:20'),
    ),
  );
  temp.remove(DaysOfWeek.friday.name);
  temp.remove(DaysOfWeek.sunday.name);
  return ServiceProvidersModel(
    displayName: 'Top Electric',
    rating: 4.9,
    // coverPhotoPath:
    //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEoq0MdUuaZhEOGtja_OI3ed-h9i3M6INv2g&s',
    coverPhotoPath: '',
    workTime: temp,
  );
}
