import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/auth/widget/sign_in.dart';
import 'package:link_win_mob_app/features/auth/widget/sign_up.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class AuthScreen extends ConsumerWidget {
  final ValueNotifier<int> _selectedTap =
      ValueNotifier(0); // 0 => Sign In , 1 => Sign Up
  AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtil screenUtil = ScreenUtil(context);
    Size headerSize = Size(
      screenUtil.widthPercentage(90),
      screenUtil.heightPercentage(10),
    );
    Size bodySize = Size(
      headerSize.width,
      screenUtil.screenHeight - 2 * headerSize.height,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: transparent,
      body: _background(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              _header(headerSize),
              _body(bodySize),
            ],
          ),
        ),
      ),
    );
  }

  _header(Size headerSize) {
    return Container(
      width: headerSize.width,
      height: headerSize.height,
      alignment: AlignmentDirectional.center,
      child: SizedBox(
        width: headerSize.width * 0.5,
        height: headerSize.height * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(FontAwesomeIcons.link),
            Text(
              'LinkWin',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _background({required Widget child}) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size childSize = Size(maxSize.width * 0.9, maxSize.height * 0.9);
        return Container(
            width: maxSize.width,
            height: maxSize.height,
            color: kWhite,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: maxSize.width,
                    height: maxSize.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: AlignmentDirectional.topEnd,
                          end: AlignmentDirectional.bottomStart,
                          stops: [
                            0.2,
                            0.4,
                            0.5,
                            0.8,
                            0.9
                          ],
                          colors: [
                            kHeaderColor,
                            kSelectedTabColor.withOpacity(0.4),
                            kUnSelectedTabColor.withOpacity(0.3),
                            kHeaderColor.withOpacity(0.7),
                            kHeaderColor
                          ]),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(maxSize.width * 0.4),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: (maxSize.height - childSize.height) * 0.5,
                  left: (maxSize.width - childSize.width) * 0.5,
                  child: SizedBox(
                    width: childSize.width,
                    height: childSize.height,
                    child: child,
                  ),
                ),
              ],
            ));
      },
    );
  }

  _body(Size size) {
    Size headerSize = Size(size.width, size.height * 0.1);
    Size bodySize = Size(size.width, size.height - headerSize.height);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          SizedBox(
            width: headerSize.width,
            height: headerSize.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tabWidget(headerSize, 'Sign In', 0),
                _tabWidget(headerSize, 'Sign Up', 1),
              ],
            ),
          ),
          _tabViewCard(bodySize),
        ],
      ),
    );
  }

  _tabViewCard(Size size) {
    Radius radius = Radius.circular(size.width * 0.15);
    double leftRightPad = size.width * 0.05;
    double topBottomPad = size.height * 0.05;
    Size bodySize =
        Size(size.width - 2 * leftRightPad, size.height - 2 * topBottomPad);
    return ValueListenableBuilder(
        valueListenable: _selectedTap,
        builder: (context, value, child) {
          bool isSignInSelected = value == 0;
          return Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.only(
              top: topBottomPad,
              bottom: topBottomPad,
              left: leftRightPad,
              right: leftRightPad,
            ),
            decoration: BoxDecoration(
              color: auSCardColor,
              borderRadius: isSignInSelected
                  ? BorderRadius.only(
                      bottomLeft: radius,
                      bottomRight: radius,
                      topRight: radius,
                    )
                  : BorderRadius.only(
                      bottomLeft: radius,
                      bottomRight: radius,
                      topLeft: radius,
                    ),
            ),
            child: isSignInSelected
                ? SignIn(
                    size: bodySize,
                  )
                : SignUp(
                    size: bodySize,
                  ),
          );
        });
  }

  _tabWidget(Size headerSize, String label, int index) {
    return ValueListenableBuilder(
        valueListenable: _selectedTap,
        builder: (context, value, child) {
          bool isSelected = value == index;
          return InkWell(
            onTap: () => _selectedTap.value = index,
            child: Container(
              width: headerSize.width * 0.48,
              height: headerSize.height,
              decoration: !isSelected
                  ? _boxDecorationOfSelectedStyle(isSelected, headerSize)
                  : _boxDecorationOfUnselectedStyle(headerSize),
              alignment: AlignmentDirectional.center,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }

  _boxDecorationOfUnselectedStyle(Size headerSize) {
    return BoxDecoration(
      color: auSCardColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(headerSize.width * 0.1),
        topRight: Radius.circular(headerSize.width * 0.1),
      ),
    );
  }

  _boxDecorationOfSelectedStyle(bool isSelected, Size headerSize) {
    return BoxDecoration(
      color: !isSelected ? transparent : auSCardColor,
    );
  }
}
