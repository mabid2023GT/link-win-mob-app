import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen/home_screen_app_bar.dart';
import 'package:link_win_mob_app/providers/auth/auth_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/providers/auth/user_provider.dart';
import 'package:link_win_mob_app/core/models/profile/user_info.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:link_win_mob_app/widgets/link_win_text_field_widget.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isEditedMode = false;
  bool isOk = true;
  UserInformation user = Users.user;
  late UserInformation editedUser;

  @override
  void initState() {
    super.initState();
    editedUser = user.copy();
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;

    // Check if the user is signed in
    if (user == null) {
      context.go('/auth');
    }

    ScreenUtil screenUtil = ScreenUtil(context);
    if (!isEditedMode) {
      editedUser.updateUserInfo(
        UserInformation(
          docId: 'user!.uid',
          firstName: 'firstName',
          lastName: 'lastName',
          phoneNumber: 'phoneNumber',
          imgUrl: 'imgUrl',
          email: 'email',
        ),
      );
    }

    return Scaffold(
      backgroundColor: transparent,
      appBar: const HomeScreenAppBar(),
      body: AutoResponsivePercentageLayout(
        screenUtil: screenUtil,
        isRow: false,
        percentages: const [5, 20, 70, 5],
        children: [
          const SizedBox(),
          _buildCircleAvatar(),
          _profileDetails(screenUtil),
          const SizedBox(),
        ],
      ),
    );
  }

  _profileDetails(ScreenUtil screenUtil) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        double leftRightPadding = maxSize.width * 0.05;
        double topBottomPadding = maxSize.height * 0.05;
        return Container(
          width: maxSize.width,
          height: maxSize.height,
          padding: EdgeInsets.only(
            left: leftRightPadding,
            right: leftRightPadding,
            top: topBottomPadding,
            bottom: topBottomPadding,
          ),
          child: AutoResponsivePercentageLayout(
            screenUtil: screenUtil,
            isRow: false,
            percentages: isEditedMode
                ? [15, 5, 15, 5, 15, 5, 15, 5, 15, 5]
                : [
                    15,
                    5,
                    15,
                    5,
                    15,
                    5,
                    15,
                    5,
                    15,
                    5,
                  ],
            children: [
              if (!isEditedMode) ...[
                LayoutBuilderChild(child: (minSize, maxSize) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LinkWinIcon(
                        iconData: Icons.edit,
                        iconSize: Size(maxSize.height, maxSize.height),
                        iconSizeRatio: 0.7,
                        iconColor: kBlack,
                        splashColor: kSelectedTabColor,
                        backgroundColor: Colors.amber,
                        onTap: () {
                          setState(() {
                            isEditedMode = true;
                          });
                        },
                      ),
                    ],
                  );
                }),
                const SizedBox(),
              ],
              _detailsWidgetLayout(Icons.person, 'First Name', user.firstName,
                  (firstName) {
                editedUser.firstName = firstName;
              }, validateName),
              const SizedBox(),
              _detailsWidgetLayout(Icons.person, 'Surname', user.lastName,
                  (lastName) {
                editedUser.lastName = lastName;
              }, validateName),
              const SizedBox(),
              _detailsWidgetLayout(Icons.email, 'Email', user.email, (email) {
                editedUser.email = email;
              }, validateEmail),
              const SizedBox(),
              _detailsWidgetLayout(Icons.phone, 'Phone', user.phoneNumber,
                  (phoneNumber) {
                editedUser.phoneNumber = phoneNumber;
              }, validatePhoneNumber),
              const SizedBox(),
              if (isEditedMode) ...[
                _actionsWidget(screenUtil),
                const SizedBox(),
              ]
            ],
          ),
        );
      },
    );
  }

  _detailsWidgetLayout(IconData icon, String label, String value,
      ValueChanged<String> onChanged, String? Function(String)? validateValue) {
    return LayoutBuilderChild(child: (minSize, maxSize) {
      return isEditedMode
          ? Container(
              width: maxSize.width,
              height: maxSize.height,
              alignment: AlignmentDirectional.centerStart,
              child: LWTextFieldWidget(
                label: label,
                hint: value,
                icon: icon,
                onChanged: onChanged,
                validateValue: validateValue,
              ))
          : SizedBox(
              width: maxSize.width,
              height: maxSize.height,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(maxSize.width * 0.0)),
                elevation: 4,
                child: ListTile(
                  leading: Icon(icon, color: kBlue),
                  title: Column(
                    children: [
                      Container(
                        width: maxSize.width,
                        height: maxSize.height * 0.3,
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontSize: 12,
                            color: k1Gray,
                          ),
                        ),
                      ),
                      Container(
                          width: maxSize.width,
                          height: maxSize.height * 0.4,
                          alignment: AlignmentDirectional.centerStart,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
    });
  }

  _actionsWidget(ScreenUtil screenUtil) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size buttonSize = Size(maxSize.width * 0.3, maxSize.height);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _actionButton(
              buttonSize,
              'Cancel',
              onTap: () {
                setState(() {
                  isEditedMode = false;
                });
              },
            ),
            _actionButton(
              buttonSize,
              'Save',
              onTap: () {
                if (!isOk) return;
                setState(() {
                  user.updateUserInfo(editedUser);
                  isEditedMode = false;
                });
              },
            ),
          ],
        );
      },
    );
  }

  _actionButton(Size buttonSize, String label,
      {required Null Function() onTap}) {
    BorderRadius borderRadius = BorderRadius.circular(buttonSize.height * 0.3);
    return Material(
      color: transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: k1Gray,
        customBorder: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        child: Container(
          width: buttonSize.width,
          height: buttonSize.height,
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: k1Gray, width: 2),
          ),
          child: Text(label),
        ),
      ),
    );
  }

  _buildCircleAvatar() {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => Container(
        width: maxSize.width,
        height: maxSize.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: editedUser.imgUrl.isEmpty ? kRed : k1Gray,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Center(
              child: editedUser.imgUrl.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              isEditedMode ? editedUser.imgUrl : user.imgUrl),
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : Text(
                      createShortenedName(editedUser),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: kWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
            if (isEditedMode)
              Positioned(
                bottom: maxSize.height * 0,
                right: maxSize.width * 0.5,
                child: LinkWinIcon(
                  iconData: Icons.edit,
                  iconSize: Size(maxSize.height * 0.2, maxSize.height * 0.2),
                  iconSizeRatio: 0.7,
                  iconColor: kBlack,
                  splashColor: kSelectedTabColor,
                  backgroundColor: Colors.amber,
                  onTap: () {
                    _showImageDialog();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  String createShortenedName(UserInformation user) {
    String res = "";
    if (user.firstName.isNotEmpty) {
      res = res + user.firstName[0];
    }

    if (user.lastName.isNotEmpty) {
      res = res + user.lastName[0];
    }

    return res;
  }

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
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () async {
                  _pickImage(ImageSource.camera);
                },
              ),
              if (true) // Only show remove option if image exists
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Remove Image'),
                  onTap: () {
                    setState(() {
                      editedUser.imgUrl = "";
                      Navigator.pop(context); // Remove the image
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final returnImage = await picker.pickImage(source: source);
    if (returnImage == null) return;

    setState(() {
      editedUser.imgUrl = returnImage.path;
      Navigator.pop(context);
    });
  }

  String? validateName(String value) {
    String? errorText;
    if (value.isEmpty) {
      errorText = 'name is required';
    }

    setState(() {
      isOk = errorText == null ? true : false;
    });

    return errorText;
  }

  String? validateEmail(String value) {
    String? errorText;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      errorText = 'Please enter a valid email';
    }

    setState(() {
      isOk = errorText == null ? true : false;
    });

    return errorText;
  }

  String? validatePhoneNumber(String value) {
    String? errorText;
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
