import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_appointment_model.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_model.dart';
import 'package:link_win_mob_app/core/services/firestore/interfaces/service_providers_interface.dart';

class ServiceProvidersApi extends ServiceProvidersInterface {
  @override
  Future<void> addServiceProvider(
      ServiceProvidersModel serviceProvider,
      void Function(DocumentReference<Object?> val) onSuccess,
      void Function(dynamic error) onError) {
    // TODO: implement addServiceProvider
    throw UnimplementedError();
  }

  @override
  Future<void> deleteServiceProvider(String serviceProviderId,
      void Function() onSuccess, void Function(dynamic error) onError) {
    // TODO: implement deleteServiceProvider
    throw UnimplementedError();
  }

  @override
  Stream<ServiceProvidersModel?> getServiceProviderByIdStream(
      String serviceProviderId) {
    // TODO: implement getServiceProviderByIdStream
    throw UnimplementedError();
  }

  @override
  Stream<List<ServiceProvidersModel>> getServiceProvidersStream() {
    // TODO: implement getServiceProvidersStream
    throw UnimplementedError();
  }

  @override
  Future<void> updateServiceProvider(ServiceProvidersModel serviceProvider,
      void Function() onSuccess, void Function(dynamic error) onError) {
    // TODO: implement updateServiceProvider
    throw UnimplementedError();
  }

  @override
  Stream<List<ServiceProvidersAppointmentModel>>
      fetchUserServiceProvidersAppointments(String userId) {
    // TODO: implement fetchUserServiceProvidersAppointments
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserServiceProvidersAppointments(
      String userId,
      ServiceProvidersAppointmentModel appointment,
      void Function() onSuccess,
      void Function(dynamic error) onError) {
    // TODO: implement updateUserServiceProvidersAppointments
    throw UnimplementedError();
  }

  @override
  Future<void> addUserServiceProvidersAppointments(
      String userId,
      ServiceProvidersAppointmentModel appointment,
      void Function() onSuccess,
      void Function(dynamic error) onError) {
    // TODO: implement addUserServiceProvidersAppointments
    throw UnimplementedError();
  }
}
