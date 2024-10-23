import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/widgets/popups/common/common_popup_layout.dart';

class WaitingPopup extends StatelessWidget {
  final String title;
  final String waitingMessage;
  final String message;
  const WaitingPopup({
    super.key,
    required this.title,
    required this.waitingMessage,
    required this.message,
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
              FontAwesomeIcons.circleInfo,
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
              child: _textBox(waitingMessage, 16, FontWeight.w600),
            ),
            _spaceBox(childSize),
            Padding(
              padding: EdgeInsets.only(
                left: messageBoxSidePad,
                right: messageBoxSidePad,
              ),
              child: _textBox(message, 16, FontWeight.w500),
            ),
            _spaceBox(childSize),
            CircularProgressIndicator(
              color: kBlue,
            )
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
