import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_win_mob_app/core/models/feed/feed_sponsored_ads_data.dart';
import 'package:link_win_mob_app/core/services/constants/feed_sponsored_constants.dart';
import 'package:link_win_mob_app/core/services/firestore/interfaces/feed_sponsored_interface.dart';

class FeedSponsoredApi implements FeedSponsoredInterface {
  // Singleton
  FeedSponsoredApi._privateConstructor();
  static final FeedSponsoredApi _instance =
      FeedSponsoredApi._privateConstructor();
  static FeedSponsoredApi get instance => _instance;

  final CollectionReference sponsoredCol =
      FirebaseFirestore.instance.collection(sponsoredCollection);

  @override
  Future<void> addSponsoredAd(
      FeedSponsoredAdsData ad,
      void Function(DocumentReference<Object?> val) onSuccess,
      void Function(dynamic error) onError) {
    return sponsoredCol
        .add(ad.toMap())
        .then((val) => onSuccess(val))
        .catchError((error) => onError(error));
  }

  @override
  Future<void> updateSponsoredAd(FeedSponsoredAdsData ad,
      void Function() onSuccess, void Function(dynamic error) onError) {
    return sponsoredCol
        .doc(ad.ownerId)
        .update(ad.toMap())
        .then((val) => onSuccess())
        .catchError((error) => onError(error));
  }

  @override
  Future<void> deleteSponsoredAd(FeedSponsoredAdsData ad,
      void Function() onSuccess, void Function(dynamic error) onError) {
    return sponsoredCol
        .doc(ad.ownerId)
        .delete()
        .then((val) => onSuccess())
        .catchError((error) => onError(error));
  }

  @override
  Stream<List<FeedSponsoredAdsData>> getSponsoredAdsStream() {
    return sponsoredCol.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FeedSponsoredAdsData.fromMap(
            doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Stream<FeedSponsoredAdsData?> getUserByIdStream(String sponsoredAdId) {
    return sponsoredCol.doc(sponsoredAdId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return FeedSponsoredAdsData.fromMap(
            snapshot.id, snapshot.data() as Map<String, dynamic>);
      }
      return null;
    });
  }
}
