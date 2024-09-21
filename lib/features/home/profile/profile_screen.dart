import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen_widgets/home_screen_app_bar.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/features/home/profile/edit_profile.dart';
import 'package:link_win_mob_app/providers/profile/user_provider.dart';
import 'package:link_win_mob_app/core/models/profile_user_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserInformation user = Users.user;

  void updateName(UserInformation editedUser) {
    setState(() {
      print('${editedUser.firstName} ${editedUser.lastName}');
      user = editedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);

    return Scaffold(
      backgroundColor: transparent,
      appBar: const HomeScreenAppBar(),
      body: AutoResponsivePercentageLayout(
        screenUtil: screenUtil,
        isRow: false,
        percentages: const [1, 99],
        children: [
          const SizedBox(),
          Center(
            child: Column(
              children: [
                EditProfile.buildCircleAvatar(user: user),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfile(
                            user: user.copy(),
                            onSave: updateName,
                          ),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: kWhite,
                        backgroundColor: kBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
