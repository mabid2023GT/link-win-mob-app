import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_win_mob_app/core/models/profile/user_info.dart';
import 'package:link_win_mob_app/core/services/constants/profile_constants.dart';
import 'package:link_win_mob_app/core/services/firestore/interfaces/users_interface.dart';

class UsersApi implements UsersInterface {
  // Singleton
  UsersApi._privateConstructor();
  static final UsersApi _instance = UsersApi._privateConstructor();
  static UsersApi get instance => _instance;

  final CollectionReference _usersCol =
      FirebaseFirestore.instance.collection(userCollection);

  @override
  Future<void> addUser(
    UserInformation user,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  ) {
    return _usersCol
        .add(user.toMap())
        .then((val) => onSuccess())
        .catchError((error) => onError(error));
  }

  @override
  Future<void> updateUser(
    UserInformation user,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  ) {
    return _usersCol
        .doc(user.docId)
        .update(user.toMap())
        .then((val) => onSuccess())
        .catchError((error) => onError(error));
  }

  @override
  Future<void> deleteUser(String userId, void Function() onSuccess,
      void Function(dynamic error) onError) {
    return _usersCol
        .doc(userId)
        .delete()
        .then((val) => onSuccess())
        .catchError((error) => onError(error));
  }

  @override
  Stream<List<UserInformation>> getUsersStream() {
    return _usersCol.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserInformation.fromMap(
            doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Stream<UserInformation?> getUserByIdStream(String userId) {
    return _usersCol.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserInformation.fromMap(
            snapshot.id, snapshot.data() as Map<String, dynamic>);
      }
      return null;
    });
  }
}
