import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_data.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_action_details.dart';

abstract class FeedPostInterface {
  /// Adds a new feed post to the database.
  ///
  /// This method takes a [FeedPostData] object representing the details
  /// of the feed post. Upon successful addition of the post, the [onSuccess]
  /// callback is invoked with the document reference of the newly created post.
  /// If there is an error during the process, the [onError] callback is triggered
  /// with the error information.
  ///
  /// Parameters:
  /// - [feedPost]: The [FeedPostData] object containing details of the post to be added.
  /// - [onSuccess]: A callback function that receives a [DocumentReference]
  ///   pointing to the newly added feed post document.
  /// - [onError]: A callback function that receives the error information if
  ///   the addition fails.
  Future<void> addFeedPost(
    FeedPostData feedPost,
    void Function(DocumentReference<Object?> val) onSuccess,
    void Function(dynamic error) onError,
  );

  /// Updates an existing feed post in the database.
  ///
  /// This method takes a [FeedPostData] object containing the updated details
  /// of the feed post. Upon successful update, the [onSuccess] callback is invoked.
  /// If an error occurs during the update process, the [onError] callback is triggered
  /// with the error information.
  ///
  /// Parameters:
  /// - [feedPost]: The [FeedPostData] object containing the updated post details.
  /// - [onSuccess]: A callback function that is invoked upon successful update.
  /// - [onError]: A callback function that receives the error information if
  ///   the update fails.
  Future<void> updateFeedPost(
    FeedPostData feedPost,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  );

  /// Deletes a feed post from the database based on the provided post ID.
  ///
  /// This method takes a [String] representing the unique identifier of the feed post
  /// to be deleted. Upon successful deletion, the [onSuccess] callback is invoked.
  /// If an error occurs during the deletion process, the [onError] callback is triggered
  /// with the error information.
  ///
  /// Parameters:
  /// - [feedPostId]: A [String] representing the unique identifier of the feed post to be deleted.
  /// - [onSuccess]: A callback function that is invoked upon successful deletion.
  /// - [onError]: A callback function that receives the error information if
  ///   the deletion fails.
  Future<void> deleteFeedPost(
    String feedPostId,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  );

  /// Adds a new action (e.g., comment, like) for a specific post.
  ///
  /// This method takes a [String] representing the unique identifier of the feed post,
  /// also takes the type of the action(comment/like...), also take the action content. Upon successful adding the action, the [onSuccess] callback is invoked.
  /// If an error occurs during the deletion process, the [onError] callback is triggered
  /// with the error information.
  ///
  /// Parameters:
  /// - [postId]: A [String] representing the unique identifier of the feed post
  ///   - [actionType]: A [String] representing the type of the action.
  ///  - [actionData]: A [FeedPostActionDetails] holding the action details.
  /// - [onSuccess]: A callback function that is invoked upon successful adding the action.
  /// - [onError]: A callback function that receives the error information if
  ///   the adding fails.
  Future<void> addAction(
    String postId,
    String actionType,
    FeedPostActionDetails actionData,
    void Function(DocumentReference<Object?> val) onSuccess,
    void Function(dynamic error) onError,
  );

  /// Update an action(coment and review only) for a specific post.
  ///
  /// This method takes a [String] representing the unique identifier of the feed post,
  /// also takes the type of the action(comment or review), also take the action content. Upon successful updating the action, the [onSuccess] callback is invoked.
  /// If an error occurs during the updating process, the [onError] callback is triggered
  /// with the error information.
  ///
  /// Parameters:
  /// - [postId]: A [String] representing the unique identifier of the feed post
  ///   - [actionType]: A [String] representing the type of the action.
  ///  - [actionData]: A [FeedPostActionDetails] holding the action details.
  /// - [onSuccess]: A callback function that is invoked upon successful updating the action.
  /// - [onError]: A callback function that receives the error information if
  ///   the updating fails.
  Future<void> updateAction(
    String postId,
    String actionType,
    FeedPostActionDetails actionData,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  );

  /// Delets an action (e.g., comment, like) for a specific post rom the database based on the provided action ID..
  ///
  /// This method takes a [String] representing the unique identifier of the feed post,
  /// also takes the type of the action(comment/like...), also takes the action id . Upon successful deleting the action, the [onSuccess] callback is invoked.
  /// If an error occurs during the deletion process, the [onError] callback is triggered
  /// with the error information.
  ///
  /// Parameters:
  /// - [postId]: A [String] representing the unique identifier of the feed post
  ///   - [actionType]: A [String] representing the type of the action.
  /// - [actionId]: A [String] representing the unique identifier of the action which will be deleted
  /// - [onSuccess]: A callback function that is invoked upon successful deleting the action.
  /// - [onError]: A callback function that receives the error information if
  ///   the deletion fails.
  Future<void> deleteAction(
    String postId,
    String actionType,
    String actionId,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  );

  /// Retrieves a stream of feed posts from the database.
  ///
  /// This method returns a [Stream] of lists containing [FeedPostData] objects.
  /// The stream continuously emits updates whenever there are changes to the feed posts
  /// in the database, allowing real-time updates to the user interface.
  ///
  /// Returns:
  /// A [Stream] of [List<FeedPostData>] representing the current feed posts
  /// in the database.
  Stream<List<FeedPostData>> getFeedPostsStream();

  /// Retrieves a stream of feed post information based on the given post ID.
  ///
  /// This method returns a [Stream] that emits [FeedPostData] objects corresponding
  /// to the feed post with the specified [feedPostId]. If the post is not found, it will
  /// emit `null`. This allows for real-time updates of feed post data, ensuring that any
  /// changes made to the post's information in the database are reflected in the application.
  ///
  /// Parameters:
  /// - [feedPostId]: A [String] representing the unique identifier of the feed post
  ///   to be retrieved.
  ///
  /// Returns:
  /// A [Stream] that emits [FeedPostData] objects. The stream will continue to emit
  /// updates as changes occur to the feed post's information in the database, or it will
  /// emit `null` if the post is not found.
  Stream<FeedPostData?> getFeedPostByIdStream(String feedPostId);

  /// Retrieves a stream of comments of the feed post based on the given post id from the database.
  ///
  /// This method returns a [Stream] of lists containing [FeedPostActionDetails] objects.
  /// The stream continuously emits updates whenever there are changes to the comments
  /// in the database, allowing real-time updates to the user interface.
  ///
  /// Returns:
  /// A [Stream] of [List<FeedPostActionDetails>] representing the current comments of the specified post
  /// in the database.
  Stream<List<FeedPostActionDetails>> fetchAllComments(String postId);

  /// Retrieves a stream of reviews of the feed post based on the given post id from the database.
  ///
  /// This method returns a [Stream] of lists containing [FeedPostActionDetails] objects.
  /// The stream continuously emits updates whenever there are changes to the reviews
  /// in the database, allowing real-time updates to the user interface.
  ///
  /// Returns:
  /// A [Stream] of [List<FeedPostActionDetails>] representing the current reviews of the specified post
  /// in the database.
  Stream<List<FeedPostActionDetails>> fetchAllReviews(String postId);

  /// Retrieves a stream of likes of the feed post based on the given post id from the database.
  ///
  /// This method returns a [Stream] of lists containing [FeedPostActionDetails] objects.
  /// The stream continuously emits updates whenever there are changes to the likes
  /// in the database, allowing real-time updates to the user interface.
  ///
  /// Returns:
  /// A [Stream] of [List<FeedPostActionDetails>] representing the current likes of the specified post
  /// in the database.
  Stream<List<FeedPostActionDetails>> fetchAllLikes(String postId);

  /// Retrieves a stream of favorites of the feed post based on the given post id from the database.
  ///
  /// This method returns a [Stream] of lists containing [FeedPostActionDetails] objects.
  /// The stream continuously emits updates whenever there are changes to the favorites
  /// in the database, allowing real-time updates to the user interface.
  ///
  /// Returns:
  /// A [Stream] of [List<FeedPostActionDetails>] representing the current favorites of the specified post
  /// in the database.
  Stream<List<FeedPostActionDetails>> fetchAllFavorites(String postId);

  /// Retrieves a stream of recommendations of the feed post based on the given post id from the database.
  ///
  /// This method returns a [Stream] of lists containing [FeedPostActionDetails] objects.
  /// The stream continuously emits updates whenever there are changes to the recommendations
  /// in the database, allowing real-time updates to the user interface.
  ///
  /// Returns:
  /// A [Stream] of [List<FeedPostActionDetails>] representing the current recommendations  of the specified post
  /// in the database.
  Stream<List<FeedPostActionDetails>> fetchAllRecommendations(String postId);
}
