import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_model.dart';
import 'package:link_win_mob_app/core/services/constants/service_providers_constants.dart';
import 'package:link_win_mob_app/core/services/firestore/interfaces/service_providers_interface.dart';

class ServiceProvidersApi implements ServiceProvidersInterface {
  // Singleton
  ServiceProvidersApi._privateConstructor();
  static final ServiceProvidersApi _instance =
      ServiceProvidersApi._privateConstructor();
  static ServiceProvidersApi get instance => _instance;

  final CollectionReference serviceProviderCol =
      FirebaseFirestore.instance.collection(serviceCollection);

  @override
  Future<void> addServiceProvider(
      ServiceProvidersModel serviceProvider,
      void Function(DocumentReference<Object?> val) onSuccess,
      void Function(dynamic error) onError) {
    return serviceProviderCol
        .add(serviceProvider.toMap())
        .then((val) => onSuccess(val))
        .catchError((error) => onError(error));
  }

  @override
  Future<void> updateServiceProvider(ServiceProvidersModel serviceProvider,
      void Function() onSuccess, void Function(dynamic error) onError) {
    return serviceProviderCol
        .doc(serviceProvider.serviceId)
        .update(serviceProvider.toMap())
        .then((val) => onSuccess())
        .catchError((error) => onError(error));
  }

  @override
  Future<void> deleteServiceProvider(String serviceProviderId,
      void Function() onSuccess, void Function(dynamic error) onError) {
    return serviceProviderCol
        .doc(serviceProviderId)
        .delete()
        .then((val) => onSuccess())
        .catchError((error) => onError(error));
  }

  @override
  Stream<List<ServiceProvidersModel>> getServiceProvidersStream() {
    return serviceProviderCol.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ServiceProvidersModel.fromMap(
            doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Stream<ServiceProvidersModel?> getServiceProviderByIdStream(
      String serviceProviderId) {
    return serviceProviderCol
        .doc(serviceProviderId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return ServiceProvidersModel.fromMap(
            snapshot.id, snapshot.data() as Map<String, dynamic>);
      }
      return null;
    });
  }
}
