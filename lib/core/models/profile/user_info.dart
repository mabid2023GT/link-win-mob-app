import 'package:link_win_mob_app/core/services/constants/profile_constants.dart';

class UserInformation {
  String docId;
  String firstName;
  String lastName;
  String phoneNumber;
  String imgUrl;
  String email;

  UserInformation({
    required this.docId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.imgUrl,
    required this.email,
  });

  String get displayName => '$firstName $lastName';

  UserInformation copy({
    String? docId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? imgUrl,
    String? email,
  }) {
    return UserInformation(
      docId: docId ?? '',
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imgUrl: imgUrl ?? this.imgUrl,
      email: email ?? this.email,
    );
  }

  void updateUserInfo(UserInformation user) {
    firstName = user.firstName;
    lastName = user.lastName;
    email = user.email;
    phoneNumber = user.phoneNumber;
    imgUrl = user.imgUrl;
  }

  Map<String, dynamic> toMap() {
    return {
      firstNameAttr: firstName,
      lastNameAttr: lastName,
      emailAttr: email,
      phoneAttr: phoneNumber,
      imageUrlAttr: imgUrl,
    };
  }

  factory UserInformation.fromMap(String docId, Map<String, dynamic> map) {
    return UserInformation(
      docId: docId,
      firstName: map[firstNameAttr],
      lastName: map[lastNameAttr],
      phoneNumber: map[phoneAttr],
      imgUrl: map[imageUrlAttr],
      email: map[emailAttr],
    );
  }
}
