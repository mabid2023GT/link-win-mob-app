import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_model.dart';

abstract class ServiceProvidersInterface {
  /// Adds a new service provider to the database.
  ///
  /// This method takes a [ServiceProvidersModel] object representing the details
  /// of the service provider. Upon successful addition of the provider, the [onSuccess]
  /// callback is invoked with the document reference of the newly created provider.
  /// If there is an error during the process, the [onError] callback is triggered
  /// with the error information.
  ///
  /// Parameters:
  /// - [serviceProvider]: The [ServiceProvidersModel] object containing details of
  ///   the service provider to be added.
  /// - [onSuccess]: A callback function that receives a [DocumentReference]
  ///   pointing to the newly added service provider document.
  /// - [onError]: A callback function that receives the error information if
  ///   the addition fails.
  Future<void> addServiceProvider(
    ServiceProvidersModel serviceProvider,
    void Function(DocumentReference<Object?> val) onSuccess,
    void Function(dynamic error) onError,
  );

  /// Updates an existing service provider in the database.
  ///
  /// This method takes a [ServiceProvidersModel] object containing the updated details
  /// of the service provider. Upon successful update, the [onSuccess] callback is invoked.
  /// If an error occurs during the update process, the [onError] callback is triggered
  /// with the error information.
  ///
  /// Parameters:
  /// - [serviceProvider]: The [ServiceProvidersModel] object containing the updated
  ///   provider details.
  /// - [onSuccess]: A callback function that is invoked upon successful update.
  /// - [onError]: A callback function that receives the error information if
  ///   the update fails.
  Future<void> updateServiceProvider(
    ServiceProvidersModel serviceProvider,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  );

  /// Deletes a service provider from the database based on the provided provider ID.
  ///
  /// This method takes a [String] representing the unique identifier of the service provider
  /// to be deleted. Upon successful deletion, the [onSuccess] callback is invoked.
  /// If an error occurs during the deletion process, the [onError] callback is triggered
  /// with the error information.
  ///
  /// Parameters:
  /// - [serviceProviderId]: A [String] representing the unique identifier of the
  ///   service provider to be deleted.
  /// - [onSuccess]: A callback function that is invoked upon successful deletion.
  /// - [onError]: A callback function that receives the error information if
  ///   the deletion fails.
  Future<void> deleteServiceProvider(
    String serviceProviderId,
    void Function() onSuccess,
    void Function(dynamic error) onError,
  );

  /// Retrieves a stream of service providers from the database.
  ///
  /// This method returns a [Stream] of lists containing [ServiceProvidersModel] objects.
  /// The stream continuously emits updates whenever there are changes to the service providers
  /// in the database, allowing real-time updates to the user interface.
  ///
  /// Returns:
  /// A [Stream] of [List<ServiceProvidersModel>] representing the current service providers
  /// in the database.
  Stream<List<ServiceProvidersModel>> getServiceProvidersStream();

  /// Retrieves a stream of service provider information based on the given provider ID.
  ///
  /// This method returns a [Stream] that emits [ServiceProvidersModel] objects corresponding
  /// to the service provider with the specified [serviceProviderId]. If the provider is not found, it will
  /// emit `null`. This allows for real-time updates of service provider data, ensuring that any
  /// changes made to the provider's information in the database are reflected in the application.
  ///
  /// Parameters:
  /// - [serviceProviderId]: A [String] representing the unique identifier of the service provider
  ///   to be retrieved.
  ///
  /// Returns:
  /// A [Stream] that emits [ServiceProvidersModel] objects. The stream will continue to emit
  /// updates as changes occur to the service provider's information in the database, or it will
  /// emit `null` if the provider is not found.
  Stream<ServiceProvidersModel?> getServiceProviderByIdStream(
      String serviceProviderId);
}
