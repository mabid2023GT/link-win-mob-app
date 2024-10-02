import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_win_mob_app/core/models/feed/feed_sponsored_ads_data.dart';

abstract class FeedSponsoredInterface {
  /// Adds a new sponsored ad to the database.
  ///
  /// This method takes a [FeedSponsoredAdsData] object representing the details
  /// of the sponsored ad. Upon successful addition of the ad, the [onSuccess]
  /// callback is invoked with the document reference of the newly created ad.
  /// If there is an error during the process, the [onError] callback is triggered
  /// with the error information.
  ///
  /// Parameters:
  /// - [ad]: The [FeedSponsoredAdsData] object containing details of the ad to be added.
  /// - [onSuccess]: A callback function that receives a [DocumentReference]
  ///   pointing to the newly added sponsored ad document.
  /// - [onError]: A callback function that receives the error information if
  ///   the addition fails.
  Future<void> addSponsoredAd(
    FeedSponsoredAdsData ad,
    void Function(DocumentReference<Object?> val) onSuccess,
    void Function(dynamic error) onError,
  );

  /// Updates an existing sponsored ad in the database.
  ///
  /// This method takes a [FeedSponsoredAdsData] object containing the updated details
  /// of the sponsored ad. Upon successful update, the [onSuccess] callback is invoked.
  /// If an error occurs during the update process, the [onError] callback is triggered
  /// with the error information.
  ///
  /// Parameters:
  /// - [ad]: The [FeedSponsoredAdsData] object containing the updated ad details.
  /// - [onSuccess]: A callback function that is invoked upon successful update.
  /// - [onError]: A callback function that receives the error information if
  ///   the update fails.
  Future<void> updateSponsoredAd(
    FeedSponsoredAdsData ad,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  );

  /// Deletes a sponsored ad from the database.
  ///
  /// This method takes a [FeedSponsoredAdsData] object representing the ad to be deleted.
  /// Upon successful deletion, the [onSuccess] callback is invoked. If an error occurs
  /// during the deletion process, the [onError] callback is triggered with the error information.
  ///
  /// Parameters:
  /// - [ad]: The [FeedSponsoredAdsData] object representing the ad to be deleted.
  /// - [onSuccess]: A callback function that is invoked upon successful deletion.
  /// - [onError]: A callback function that receives the error information if
  ///   the deletion fails.
  Future<void> deleteSponsoredAd(
    FeedSponsoredAdsData ad,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  );

  /// Retrieves a stream of sponsored ads from the database.
  ///
  /// This method returns a [Stream] of lists containing [FeedSponsoredAdsData] objects.
  /// The stream continuously emits updates whenever there are changes to the sponsored ads
  /// in the database, allowing real-time updates to the user interface.
  ///
  /// Returns:
  /// A [Stream] of [List<FeedSponsoredAdsData>] representing the current sponsored ads
  /// in the database.
  Stream<List<FeedSponsoredAdsData>> getSponsoredAdsStream();

  /// Retrieves a stream of sponsored ad information based on the given ad ID.
  ///
  /// This method returns a [Stream] that emits [FeedSponsoredAdsData] objects corresponding
  /// to the sponsored ad with the specified [sponsoredAdId]. If the ad is not found, it will
  /// emit `null`. This allows for real-time updates of sponsored ad data, ensuring that any
  /// changes made to the ad's information in the database are reflected in the application.
  ///
  /// Parameters:
  /// - [sponsoredAdId]: A [String] representing the unique identifier of the sponsored ad
  ///   to be retrieved.
  ///
  /// Returns:
  /// A [Stream] that emits [FeedSponsoredAdsData] objects. The stream will continue to emit
  /// updates as changes occur to the sponsored ad's information in the database, or it will
  /// emit `null` if the ad is not found.
  Stream<FeedSponsoredAdsData?> getUserByIdStream(String sponsoredAdId);
}
