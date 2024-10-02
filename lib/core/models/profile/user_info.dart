class UserInformation {
  String firstName;
  String lastName;
  String phoneNumber;
  String imgUrl;
  String email;

  UserInformation({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.imgUrl,
    required this.email,
  });

  String get displayName => '$firstName $lastName';

  UserInformation copy({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? imgUrl,
    String? email,
  }) {
    return UserInformation(
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
}
