import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/auth/widget/sign_in.dart';
import 'package:link_win_mob_app/features/auth/widget/sign_up.dart';
import 'package:link_win_mob_app/providers/auth/auth_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class AuthScreen extends ConsumerWidget {
  final ValueNotifier<int> _selectedTap =
      ValueNotifier(0); // 0 => Sign In , 1 => Sign Up
  AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtil screenUtil = ScreenUtil(context);
    final user = ref.watch(authProvider).user;

    // Hide keyboard when the widget is disposed
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).unfocus();
    // });

    // Check if the user is signed in
    if (user != null) {
      // User is signed in, navigate to the profile page

      // return ProfileScreen();
    }
    return _authScreen(screenUtil);
  }

  _authScreen(ScreenUtil screenUtil) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: transparent,
      body: _background(
        child: AutoResponsivePercentageLayout(
          screenUtil: screenUtil,
          isRow: false,
          percentages: const [1, 15, 2, 80, 2],
          children: [
            const SizedBox(),
            _header(),
            const SizedBox(),
            _body(),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  _header() {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        return Container(
          width: maxSize.width,
          height: maxSize.height,
          alignment: AlignmentDirectional.center,
          child: SizedBox(
            width: maxSize.width * 0.4,
            height: maxSize.height * 0.8,
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
      },
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

  _body() {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size headerSize = Size(maxSize.width, maxSize.height * 0.125);
        Size bodySize = Size(maxSize.width, maxSize.height - headerSize.height);
        return SizedBox(
          width: maxSize.width,
          height: maxSize.height,
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
      },
    );
  }

  _tabViewCard(Size bodySize) {
    Radius radius = Radius.circular(bodySize.width * 0.15);
    double leftRightPad = bodySize.width * 0.05;
    double topBottomPad = bodySize.height * 0.05;
    return ValueListenableBuilder(
        valueListenable: _selectedTap,
        builder: (context, value, child) {
          bool isSignInSelected = value == 0;
          return Container(
            width: bodySize.width,
            height: bodySize.height,
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
