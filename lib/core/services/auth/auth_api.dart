import 'package:firebase_auth/firebase_auth.dart';
import 'package:link_win_mob_app/core/models/profile/user_info.dart';
import 'package:link_win_mob_app/core/services/auth/auth_interface.dart';
import 'package:link_win_mob_app/core/services/firestore/users_api.dart';

class AuthApi implements AuthInterface {
  // Singleton
  AuthApi._privateConstructor();
  static final AuthApi _instance = AuthApi._privateConstructor();
  static AuthApi get instance => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User?> signUp(UserInformation userInfo, String password,
      void Function() onSuccess, void Function(dynamic error) onError,
      {int maxRetries = 3}) async {
    try {
      // Step 1: Create the user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userInfo.email,
        password: password,
      );
      // Step 2
      // Use the UID from the authentication service
      // to create a document in the users collection,
      // with the UID as the document ID.
      userInfo = userInfo.copy(docId: userCredential.user!.uid);
      // Step 3: Try to add the user to Firestore, with retry logic
      bool addedToFirestore =
          await _addUserToFirestore(userInfo, onSuccess, onError, maxRetries);
      // Return the user if Firestore operation succeeded
      return addedToFirestore ? userCredential.user : null;
    } catch (error) {
      // Handle errors from Firebase Authentication
      onError(error);
      return null;
    }
  }

  Future<bool> _addUserToFirestore(
    UserInformation userInfo,
    void Function() onSuccess,
    void Function(dynamic error) onError,
    int maxRetries,
  ) async {
    bool success = false;
    int attempts = 0;

    while (!success && attempts < maxRetries) {
      attempts++;
      try {
        // Add the user to Firestore after successfully creating the user in the authentication service
        await UsersApi.instance.addUser(userInfo, onSuccess, (error) {});
        // If addUser succeeds, set success to true
        success = true;
      } catch (error) {
        if (attempts == maxRetries) {
          // If we've hit the max retries, delete the user from Firebase Auth
          await _auth.currentUser?.delete();
          onError("Failed to add user to Firestore after $maxRetries attempts");
          // Return null if we fail after max retries
          return false;
        }
        // Optionally, you can add a delay between retries
        // Wait 2 seconds before retrying
        await Future.delayed(Duration(seconds: 2));
      }
    }
    return success;
  }

  @override
  Future<User?> signIn(
    String email,
    String password,
    void Function(dynamic error) onError,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (error) {
      onError(error);
      return null;
    }
  }

  @override
  Future<void> signOut() async => await _auth.signOut();

  @override
  User? getCurrentUser() => _auth.currentUser;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<void> sendVerificationEmail(
    void Function() onSuccess,
    void Function(dynamic error) onError,
  ) async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        onSuccess();
      } catch (error) {
        onError(error);
      }
    }
  }
}
