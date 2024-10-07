import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/widgets/popups/linkwin_popup_layout.dart';

class AuthPopup extends StatelessWidget {
  final String title;
  final String message;
  final Duration duration;
  final Color backgroundColor;
  final Color borderColor;
  const AuthPopup({
    super.key,
    this.title = 'Signing Up ...',
    this.message = 'Kindly wait a moment; we will be done soon!',
    this.duration = const Duration(milliseconds: 300),
    this.backgroundColor = const Color.fromARGB(255, 163, 249, 240),
    this.borderColor = kBlack,
  });

  @override
  Widget build(BuildContext context) {
    return LWPopupLayout(
      title: title,
      message: message,
      duration: duration,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
    );
  }
}
