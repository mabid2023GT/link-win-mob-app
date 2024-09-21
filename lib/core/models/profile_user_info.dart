class UserInformation {
  String firstName;
  String lastName;
  String phoneNumber;
  String imgUrl;

  UserInformation({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.imgUrl,
  });

  UserInformation copy({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? imgUrl,
  }) {
    return UserInformation(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }
}
