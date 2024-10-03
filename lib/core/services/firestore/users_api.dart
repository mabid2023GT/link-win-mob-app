import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_win_mob_app/core/models/profile/user_info.dart';
import 'package:link_win_mob_app/core/services/constants/profile_constants.dart';
import 'package:link_win_mob_app/core/services/firestore/interfaces/users_interface.dart';

class UsersApi implements UsersInterface {
  final CollectionReference usersCol =
      FirebaseFirestore.instance.collection(userCollection);

  @override
  Future<void> addUser(
    UserInformation user,
    void Function(DocumentReference<Object?> val) onSuccess,
    void Function(dynamic error) onError,
  ) {
    return usersCol
        .add(user.toMap())
        .then((val) => onSuccess(val))
        .catchError((error) => onError(error));
  }

  @override
  Future<void> updateUser(
    UserInformation user,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  ) {
    return usersCol
        .doc(user.docId)
        .update(user.toMap())
        .then((val) => onSuccess())
        .catchError((error) => onError(error));
  }

  @override
  Future<void> deleteUser(String userId, void Function() onSuccess,
      void Function(dynamic error) onError) {
    return usersCol
        .doc(userId)
        .delete()
        .then((val) => onSuccess())
        .catchError((error) => onError(error));
  }

  @override
  Stream<List<UserInformation>> getUsersStream() {
    return usersCol.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserInformation.fromMap(
            doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Stream<UserInformation?> getUserByIdStream(String userId) {
    return usersCol.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserInformation.fromMap(
            snapshot.id, snapshot.data() as Map<String, dynamic>);
      }
      return null;
    });
  }
}
