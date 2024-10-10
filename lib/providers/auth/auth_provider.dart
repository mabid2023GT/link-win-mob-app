import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/profile/user_info.dart';
import 'package:link_win_mob_app/core/services/auth/auth_api.dart';

final authProvider = ChangeNotifierProvider<AuthNotifier>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends ChangeNotifier {
  User? _user;
  final AuthApi _authApi = AuthApi.instance;

  AuthNotifier() {
    _authApi.authStateChanges.listen((user) {
      _user = user;
      // Notifies listeners when the authentication state changes
      notifyListeners();
    });
  }

  User? get user => _user;

  Future<void> signUp(
    UserInformation userInfo,
    String password,
    void Function() onSuccess,
    void Function() onSignInSuccess,
    void Function(dynamic error) onError,
    void Function(dynamic error)
        onSignInError, // New callback for sign-in error
  ) async {
    User? user = await _authApi.signUp(userInfo, password, onSuccess, onError);
    if (user != null) {
      // Signup completed successfully!
      // 1. Sign out (user cannot be deleted on the first login; we ensure they have signed in at least twice).
      await signOut();
      // 2. Sign In
      await signIn(userInfo.email, password, onSignInSuccess, onSignInError);
    }
  }

  Future<void> signIn(
    String email,
    String password,
    void Function() onSignInSuccess,
    void Function(dynamic error) onError,
  ) async {
    User? user = await _authApi.signIn(email, password, onError);
    if (user != null) {
      _user = user;
      notifyListeners(); // Notify listeners to update UI or any other dependent state
      onSignInSuccess();
    }
  }

  Future<void> signOut() async {
    await _authApi.signOut();
    _user = null; // Manually set _user to null after sign out
    notifyListeners(); // Notify listeners to update UI or any other dependent state
  }

  Future<void> resetPassword(
    String email,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  ) async {
    await _authApi.sendPasswordResetEmail(email, onSuccess, onError);
  }

  Future<void> sendVerificationEmail(
    void Function() showPopup,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  ) async {
    await _authApi.sendVerificationEmail(
      () => handleUnverifiedUser(showPopup, onSuccess),
      onError,
    );
  }

  // To handle unverified users
  Future<void> handleUnverifiedUser(
    VoidCallback onUnverifiedUser,
    VoidCallback onVerifiedUser,
  ) async {
    // Show the popup initially if the user is unverified
    if (_user != null && !_user!.emailVerified) {
      // Call a method to inform the user about the verification requirement
      onUnverifiedUser();
      // Periodically check if the user is verified
      Timer.periodic(
        Duration(seconds: 3),
        (timer) async {
          // Reload user data
          await _user?.reload();
          // Get the latest user info
          _user = _authApi.getCurrentUser();
          if (_user != null && _user!.emailVerified) {
            // Stop the timer
            timer.cancel();
            // Call verified callback
            // destroy the auth page
            onVerifiedUser();
          }
        },
      );
    }
  }
}
