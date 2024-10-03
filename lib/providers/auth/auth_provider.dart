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
    void Function(dynamic error) onError,
  ) async {
    await _authApi.signUp(userInfo, password, onSuccess, onError);
  }

  Future<void> signIn(
    String email,
    String password,
    void Function(dynamic error) onError,
  ) async {
    await _authApi.signIn(email, password, onError);
  }

  Future<void> signOut() async {
    await _authApi.signOut();
  }
}
