import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/widgets/popups/auth/auth_popup.dart';
import 'package:link_win_mob_app/widgets/popups/auth/verification_email_popup.dart';

void _showFixedModalBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    enableDrag: false,
    backgroundColor: transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 1,
      maxChildSize: 1,
      minChildSize: 1,
      builder: (context, scrollController) => child,
    ),
  );
}

void showSignUpPopup(BuildContext context) =>
    _showFixedModalBottomSheet(context, AuthPopup());

void showVerificationEmailPopup(BuildContext context) =>
    _showFixedModalBottomSheet(context, VerificationEmailPopup());
