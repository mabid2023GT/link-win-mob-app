import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_data.dart';
import 'package:link_win_mob_app/core/services/constants/feed_post_constants.dart';
import 'package:link_win_mob_app/core/services/firestore/interfaces/feed_post_interface.dart';

class FeedPostApi implements FeedPostInterface {
  // Singleton
  FeedPostApi._privateConstructor();
  static final FeedPostApi _instance = FeedPostApi._privateConstructor();
  static FeedPostApi get instance => _instance;

  final CollectionReference feedPostCol =
      FirebaseFirestore.instance.collection(postCollection);

  @override
  Future<void> addFeedPost(
      FeedPostData feedPost,
      void Function(DocumentReference<Object?> val) onSuccess,
      void Function(dynamic error) onError) {
    return feedPostCol
        .add(feedPost.toMap())
        .then((val) => onSuccess(val))
        .catchError((error) => onError(error));
  }

  @override
  Future<void> updateFeedPost(FeedPostData feedPost, void Function() onSuccess,
      void Function(dynamic error) onError) {
    return feedPostCol
        .doc(feedPost.postId)
        .update(feedPost.toMap())
        .then((val) => onSuccess())
        .catchError((error) => onError(error));
  }

  @override
  Future<void> deleteFeedPost(String feedPostId, void Function() onSuccess,
      void Function(dynamic error) onError) {
    return feedPostCol
        .doc(feedPostId)
        .delete()
        .then((val) => onSuccess())
        .catchError((error) => onError(error));
  }

  @override
  Stream<List<FeedPostData>> getFeedPostsStream() {
    return feedPostCol.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FeedPostData.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Stream<FeedPostData?> getFeedPostByIdStream(String feedPostId) {
    return feedPostCol.doc(feedPostId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return FeedPostData.fromMap(
            snapshot.id, snapshot.data() as Map<String, dynamic>);
      }
      return null;
    });
  }
}
