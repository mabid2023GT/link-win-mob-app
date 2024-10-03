import 'package:link_win_mob_app/core/models/profile/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthInterface {
  Future<User?> signUp(UserInformation userInfo, String password,
      void Function() onSuccess, void Function(dynamic error) onError,
      // Add the maxRetries parameter with a default value
      {int maxRetries = 3});

  Future<User?> signIn(
    String email,
    String password,
    void Function(dynamic error) onError,
  );

  Future<void> signOut();

  User? getCurrentUser();

  Stream<User?> get authStateChanges;
}
