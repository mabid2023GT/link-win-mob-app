import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen_widgets/home_screen_app_bar.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/providers/profile/user_provider.dart';
import 'package:link_win_mob_app/core/models/profile_user_info.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:link_win_mob_app/widgets/link_win_text_field_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditedMode = false;
  UserInformation user = Users.user;

  void updateName(UserInformation editedUser) {
    setState(() {
      print('${editedUser.firstName} ${editedUser.lastName}');
      user = editedUser;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   ScreenUtil screenUtil = ScreenUtil(context);

  //   return Scaffold(
  //     backgroundColor: kAmber,
  //     appBar: const HomeScreenAppBar(),
  //     body: AutoResponsivePercentageLayout(
  //       screenUtil: screenUtil,
  //       isRow: false,
  //       percentages: const [1, 99],
  //       children: [
  //         const SizedBox(),
  //         Center(
  //           child: Column(
  //             children: [
  //               // EditProfile.buildCircleAvatar(user: user),
  //               _buildCircleAvatar(),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Text(
  //                 '${user.firstName} ${user.lastName}',
  //                 style: const TextStyle(
  //                     fontWeight: FontWeight.bold, fontSize: 24),
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               SizedBox(
  //                 width: 200,
  //                 child: ElevatedButton(
  //                   onPressed: () {
  //                     Navigator.of(context).push(MaterialPageRoute(
  //                       builder: (context) => EditProfile(
  //                         user: user.copy(),
  //                         onSave: updateName,
  //                       ),
  //                     ));
  //                   },
  //                   style: ElevatedButton.styleFrom(
  //                     foregroundColor: kWhite,
  //                     backgroundColor: kBlue,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(50),
  //                     ),
  //                   ),
  //                   child: const Text(
  //                     'Edit Profile',
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold, letterSpacing: 2),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);

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
              _detailsWidgetLayour(Icons.person, 'First Name', user.firstName),
              const SizedBox(),
              _detailsWidgetLayour(Icons.person, 'Surname', user.lastName),
              const SizedBox(),
              _detailsWidgetLayour(Icons.person, 'Email', 'ex@gmail.com'),
              const SizedBox(),
              _detailsWidgetLayour(Icons.person, 'Phone', user.phoneNumber),
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

  _detailsWidgetLayour(
    IconData icon,
    String label,
    String value,
  ) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        double iconWidth = maxSize.height;
        double restWidth = maxSize.width - iconWidth;
        Size iconSize = Size(iconWidth, iconWidth);
        Size labelSize = Size(restWidth * 0.4, maxSize.height);
        Size valueSize = Size(restWidth - labelSize.width, maxSize.height);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: iconSize.width,
              height: iconSize.height,
              alignment: AlignmentDirectional.center,
              child: Icon(icon),
            ),
            Container(
              width: labelSize.width,
              height: labelSize.height,
              alignment: AlignmentDirectional.centerStart,
              child: Text(label),
            ),
            Container(
              width: valueSize.width,
              height: valueSize.height,
              alignment: AlignmentDirectional.centerStart,
              child: isEditedMode
                  ? LWTextFieldWidget(
                      label: label,
                      text: value,
                    )
                  : Text(value),
            ),
          ],
        );
      },
    );
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
              onTap: () {},
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
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: user.imgUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(user.imgUrl),
                    fit: BoxFit.contain,
                  )
                : null,
          ),
          child: user.imgUrl.isEmpty
              ? Text(
                  createShortenedName(user),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: kWhite,
                  ),
                  textAlign: TextAlign.center,
                )
              : null),
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

  // String? validateName(String value) {
  //   String? errorText;
  //   if (value.isEmpty) {
  //     errorText = 'name is required';
  //   }

  //   setState(() {
  //     isOk = errorText == null ? true : false;
  //   });

  //   return errorText;
  // }
}
