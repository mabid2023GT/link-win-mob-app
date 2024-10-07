import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_win_mob_app/core/models/profile/user_info.dart';

abstract class UsersInterface {
  /// Adds a new user to the database.
  ///
  /// This method takes a [UserInformation] object representing the user's details.
  /// Upon successful addition of the user, the [onSuccess] callback is invoked
  /// with the document reference of the newly created user. If there is an error
  /// during the process, the [onError] callback is triggered with the error information.
  ///
  /// Parameters:
  /// - [user]: The [UserInformation] object containing user details to be added.
  /// - [onSuccess]: A callback function that receives a [DocumentReference]
  ///   pointing to the newly added user document.
  /// - [onError]: A callback function that receives the error information if
  ///   the addition fails.
  Future<void> addUser(
    UserInformation user,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  );

  /// Updates the information of an existing user in the database.
  ///
  /// This method takes a [UserInformation] object containing the updated details of
  /// the user. Upon successful update, the [onSuccess] callback is invoked with the
  /// document reference of the updated user. If an error occurs during the update
  /// process, the [onError] callback is triggered with the error information.
  ///
  /// Parameters:
  /// - [user]: The [UserInformation] object containing the updated user details.
  /// - [onSuccess]: A callback function that receives a [DocumentReference]
  ///   pointing to the updated user document.
  /// - [onError]: A callback function that receives the error information if
  ///   the update fails.
  ///
  /// Returns:
  /// A [Future<void>] that completes once the update operation is finished.
  Future<void> updateUser(
    UserInformation user,
    void Function() onSuccess,
    void Function(Object?, StackTrace) onError,
  );

  /// Deletes a user from the database based on the provided user ID.
  ///
  /// This method takes a [String] representing the unique identifier of the user
  /// to be deleted. Upon successful deletion, the [onSuccess] callback is invoked
  /// with the document reference of the deleted user. If an error occurs during
  /// the deletion process, the [onError] callback is triggered with the error information.
  ///
  /// Parameters:
  /// - [userId]: A [String] representing the unique identifier of the user to be deleted.
  /// - [onSuccess]: A callback function that receives a [DocumentReference]
  ///   pointing to the deleted user document.
  /// - [onError]: A callback function that receives the error information if
  ///   the deletion fails.
  ///
  /// Returns:
  /// A [Future<void>] that completes once the deletion operation is finished.
  Future<void> deleteUser(
    String userId,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  );

  /// Retrieves a stream of users from the database.
  ///
  /// This method returns a [Stream] of lists containing [UserInformation] objects.
  /// The stream continuously emits updates whenever there are changes to the user data
  /// in the database, allowing real-time updates to the user interface.
  ///
  /// Returns:
  /// A [Stream] of [List<UserInformation>] representing the current users in the database.
  Stream<List<UserInformation>> getUsersStream();

  /// Retrieves a stream of user information based on the given user ID.
  ///
  /// This method returns a [Stream] that emits [UserInformation] objects corresponding
  /// to the user with the specified [userId]. If the user is not found, it will emit
  /// `null`. This allows for real-time updates of user data, ensuring that any changes
  /// made to the user's information in the database are reflected in the application.
  ///
  /// Parameters:
  /// - [userId]: A [String] representing the unique identifier of the user to be retrieved.
  ///
  /// Returns:
  /// A [Stream] that emits [UserInformation] objects. The stream will continue to emit
  /// updates as changes occur to the user's information in the database, or it will emit
  /// `null` if the user is not found.
  Stream<UserInformation?> getUserByIdStream(String userId);
}
