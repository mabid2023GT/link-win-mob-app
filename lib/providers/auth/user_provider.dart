// Define the UserNotifier that handles user actions
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/profile/user_info.dart';
import 'package:link_win_mob_app/core/services/firestore/users_api.dart';

// Provider for user actions and state
final userProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<UserInformation?>>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<AsyncValue<UserInformation?>> {
  final UsersApi _usersApi = UsersApi.instance;
  UserNotifier() : super(const AsyncLoading());

  // Method to fetch user by ID as a stream
  void fetchUserById(String userId) {
    final userStream = _usersApi.getUserByIdStream(userId);
    userStream.listen((user) {
      state = AsyncValue.data(user);
    }, onError: (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    });
  }

  // Method to update user information
  Future<void> updateUser(UserInformation updatedUser) async {
    state = const AsyncLoading();
    try {
      await _usersApi.updateUser(
        updatedUser,
        () {
          // Success callback, we can fetch the updated user again if needed
          fetchUserById(updatedUser.docId);
        },
        (error, stackTrace) {
          state = AsyncValue.error(
            error ?? 'No additional information.',
            stackTrace,
          );
        },
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
