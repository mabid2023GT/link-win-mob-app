import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/widgets/buttons/link_win_button.dart';
import 'package:link_win_mob_app/widgets/popups/common/common_popup_layout.dart';

class ErrorPopup extends StatelessWidget {
  final String title;
  final String errorMessage;
  final String hintMessage;
  final String buttonLabel;
  final VoidCallback onTap;
  const ErrorPopup({
    super.key,
    required this.title,
    required this.errorMessage,
    required this.hintMessage,
    required this.buttonLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonPopupLayout(
      builder: (childSize) {
        double messageBoxSidePad = childSize.width * 0.075;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _spaceBox(childSize),
            Icon(
              FontAwesomeIcons.triangleExclamation,
              size: childSize.height * 0.1,
              color: kBlue,
            ),
            _spaceBox(childSize),
            _textBox(title, 18, FontWeight.bold),
            _spaceBox(childSize),
            Padding(
              padding: EdgeInsets.only(
                left: messageBoxSidePad,
                right: messageBoxSidePad,
              ),
              child: _textBox(errorMessage, 16, FontWeight.w600),
            ),
            _spaceBox(childSize),
            Padding(
              padding: EdgeInsets.only(
                left: messageBoxSidePad,
                right: messageBoxSidePad,
              ),
              child: _textBox(hintMessage, 16, FontWeight.w500),
            ),
            _spaceBox(childSize),
            LWButton(
              label: buttonLabel,
              onTap: onTap,
            ),
          ],
        );
      },
    );
  }

  SizedBox _spaceBox(Size childSize) {
    return SizedBox(
      height: childSize.height * 0.1,
    );
  }

  _textBox(String value, double fontSize, FontWeight fontWeight) {
    return Text(
      value,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'Lato',
      ),
    );
  }
}
