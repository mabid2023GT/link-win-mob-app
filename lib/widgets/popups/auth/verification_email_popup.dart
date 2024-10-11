import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/widgets/popups/linkwin_popup_layout.dart';

class VerificationEmailPopup extends StatelessWidget {
  const VerificationEmailPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return LWPopupLayout(
      title: 'Verification Email',
      message:
          'Please check your inbox (or spam) for a verification email and click the link to complete your signup.',
      duration: Duration(milliseconds: 300),
      backgroundColor: const Color.fromARGB(255, 163, 249, 240),
      borderColor: kBlack,
      rightButton: LWPopupLayoutButtons(
        label: 'Send Again',
        iconData: FontAwesomeIcons.arrowsRotate,
        onTap: () {},
      ),
    );
  }
}
