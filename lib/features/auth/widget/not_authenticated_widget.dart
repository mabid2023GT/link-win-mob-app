import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';

class NotAuthenticatedWidget extends ConsumerWidget {
  final double titleFontSize;
  final double contentFontSize;
  final double buttonFontSize;

  const NotAuthenticatedWidget({
    super.key,
    this.titleFontSize = 24,
    this.contentFontSize = 20,
    this.buttonFontSize = 18,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtil screenUtil = ScreenUtil(context);
    Size size = Size(
      screenUtil.widthPercentage(90),
      screenUtil.heightPercentage(60),
    );
    Size signInSize = Size(
      screenUtil.widthPercentage(12.5),
      screenUtil.heightPercentage(3),
    );
    double leftRightPad = size.width * 0.025;
    return Scaffold(
      backgroundColor: kHeaderColor,
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(
            left: leftRightPad,
            right: leftRightPad,
          ),
          child: _body(context, signInSize),
        ),
      ),
    );
  }

  _body(BuildContext context, Size signInSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _title(),
        _content(),
        _signIn(context, signInSize),
      ],
    );
  }

  _title() {
    return Text(
      'Welcome to LinkWin!',
      style: TextStyle(
        fontSize: titleFontSize,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    );
  }

  _content() {
    return Text(
      'It is our pleasure to provide you with the best services. Sign in to enjoy our amazing features, or sign up if you don’t have an account yet!',
      style: TextStyle(
        fontSize: contentFontSize,
        color: Colors.black54,
        height: 2,
      ),
    );
  }

  _signIn(BuildContext context, Size size) {
    double leftRightPad = size.width * 0.7;
    double topBottomPad = size.height * 0.7;
    return ElevatedButton(
      onPressed: () => context.go('/auth'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(
          left: leftRightPad,
          right: leftRightPad,
          top: topBottomPad,
          bottom: topBottomPad,
        ),
      ),
      child: Text(
        'Sign In',
        style: TextStyle(
          fontSize: buttonFontSize,
          fontWeight: FontWeight.bold,
          color: kBlack,
        ),
      ),
    );
  }
}
