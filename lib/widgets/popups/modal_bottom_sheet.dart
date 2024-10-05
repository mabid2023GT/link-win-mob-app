import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/widgets/popups/auth/auth_popup.dart';

void showSignUpPopup(BuildContext context) {
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
      builder: (context, scrollController) => AuthPopup(),
    ),
  );
}
