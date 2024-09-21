import 'package:link_win_mob_app/core/models/profile_user_info.dart';
import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen_widgets/home_screen_app_bar.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/widgets/text_field_widget.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  UserInformation user;
  final Function(UserInformation) onSave;

  static String CreateShortenedName(UserInformation user) {
    String res = "";
    if (user.firstName.isNotEmpty) {
      res = res + user.firstName[0];
    }

    if (user.lastName.isNotEmpty) {
      res = res + user.lastName[0];
    }

    return res;
  }

  static Widget buildCircleAvatar({
    required UserInformation user,
  }) =>
      CircleAvatar(
          radius: 60,
          backgroundColor: kRed,
          backgroundImage:
              user.imgUrl.isNotEmpty ? NetworkImage(user.imgUrl) : null,
          child: user.imgUrl.isEmpty
              ? Text(
                  EditProfile.CreateShortenedName(user),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24, color: kWhite),
                  textAlign: TextAlign.center,
                )
              : null);

  EditProfile({Key? key, required this.user, required this.onSave})
      : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isOk = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);
    return Scaffold(
        backgroundColor: transparent,
        appBar: const HomeScreenAppBar(
          imply_leading: true,
        ),
        body: AutoResponsivePercentageLayout(
            screenUtil: screenUtil,
            isRow: false,
            percentages: const [
              1,
              15,
              84
            ],
            children: [
              const SizedBox(),
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        EditProfile.buildCircleAvatar(user: widget.user),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: buildEditIcon(
                              Theme.of(context).colorScheme.primary),
                        )
                      ],
                    )
                  ],
                ),
              ),
              ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'First Name',
                      text: widget.user.firstName,
                      onChanged: (firstName) {
                        setState(() {
                          widget.user.firstName = firstName;
                        });
                      },
                      validateValue: ValidateName,
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Last Name',
                      text: widget.user.lastName,
                      onChanged: (lastName) {
                        setState(() {
                          widget.user.lastName = lastName;
                        });
                      },
                      validateValue: ValidateName,
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Phone Number',
                      text: widget.user.phoneNumber,
                      onChanged: (phoneNumber) {
                        setState(() {
                          widget.user.phoneNumber = phoneNumber;
                        });
                      },
                      validateValue: ValidatePhoneNumber,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(
                                  context); // Go back to previous screen
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: kWhite,
                              backgroundColor: kBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2),
                            )),
                        ElevatedButton(
                            onPressed: isOk
                                ? () {
                                    widget.onSave(widget.user);
                                    Navigator.pop(context);
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: kWhite,
                              backgroundColor: kBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2),
                            ))
                      ],
                    )
                  ])
            ]));
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
            color: color,
            all: 8,
            child: SizedBox(
                height: 18,
                width: 18,
                child: IconButton(
                  onPressed: () {
                    _showImageDialog();
                  },
                  padding: const EdgeInsets.all(0.0),
                  icon: const Icon(Icons.add_a_photo, size: 18.0),
                  color: Colors.white,
                ))),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile Picture'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  _PickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  _PickImage(ImageSource.camera);
                },
              ),
              if (true) // Only show remove option if image exists
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Remove Image'),
                  onTap: () {
                    setState(() {
                      widget.user.imgUrl = ""; // Remove the image
                    });
                    Navigator.pop(context); // Close dialog
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _PickImage(ImageSource source) async {
    final picker = ImagePicker();
    final returnImage = await picker.pickImage(source: source);
    if (returnImage == null) return;

    setState(() {
      widget.user.imgUrl = returnImage.path;
    });

    Navigator.pop(context);
  }

  String? ValidateName(String value) {
    String? errorText = null;
    if (value.isEmpty) {
      errorText = 'name is required';
    }

    setState(() {
      isOk = errorText == null ? true : false;
    });

    return errorText;
  }

  String? ValidatePhoneNumber(String value) {
    String? errorText = null;
    RegExp phoneRegex = RegExp(r'^\+?[0-9]*$');

    if (value.isNotEmpty &&
        (!phoneRegex.hasMatch(value) || value.length > 12)) {
      errorText = 'Please enter a valid phone number';
    }

    setState(() {
      isOk = errorText == null &&
              (value.isEmpty || (value.length >= 10 && value.length <= 12))
          ? true
          : false;
    });

    return errorText;
  }
}
