import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/providers/auth/auth_provider.dart';
import 'package:link_win_mob_app/widgets/link_win_text_field_widget.dart';
import 'package:link_win_mob_app/widgets/popups/linkwin_popup_layout.dart';

class ResetPasswordPopup extends ConsumerWidget {
  ResetPasswordPopup({super.key});

  // null if the reset button not tapped yet, if '' no error found
  final ValueNotifier<String?> _errorNotifier = ValueNotifier(null);
  final ValueNotifier<int> _widgetNotifier = ValueNotifier(0);
  final ValueNotifier<String> _emailNotifier = ValueNotifier('');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: _widgetNotifier,
      builder: (context, value, child) {
        return value == 0
            ? _resetEmailNotSendYet(context, ref)
            : value == 1
                ? _resetEmailWasSent(context)
                : _errorWidget(context);
      },
    );
  }

  _resetEmailWasSent(BuildContext context) {
    return LWPopupLayout(
      title: 'Reset Password',
      message:
          'Please check your inbox or spam folder. A reset password link has been sent to you. Click the link to reset your password, and then try signing in again.',
      duration: Duration(milliseconds: 300),
      backgroundColor: const Color.fromARGB(255, 163, 249, 240),
      borderColor: kBlack,
      rightButton: LWPopupLayoutButtons(
        label: 'Sign In',
        iconData: FontAwesomeIcons.lockOpen,
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }

  _resetEmailNotSendYet(BuildContext context, WidgetRef ref) {
    return LWPopupLayout(
      title: 'Reset Password',
      message: 'Enter your email below!',
      duration: Duration(milliseconds: 300),
      backgroundColor: const Color.fromARGB(255, 163, 249, 240),
      borderColor: kBlack,
      child: _buildChild,
      rightButton: LWPopupLayoutButtons(
        label: 'Reset',
        iconData: FontAwesomeIcons.lockOpen,
        onTap: () {
          _onResetTapped(context, ref);
        },
      ),
    );
  }

  Widget _buildChild(Size size) {
    return Container(
        width: size.width,
        height: size.height * 0.5,
        alignment: AlignmentDirectional.center,
        child: ValueListenableBuilder(
          valueListenable: _errorNotifier,
          builder: (context, value, child) => LWTextFieldWidget(
            label: 'Email',
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            fillColor: value == null || value.isEmpty
                ? kHeaderColor
                : kRed.withOpacity(0.8),
            iconSizeRatio: 0.2,
            fontSize: 12,
            onChanged: (value) {
              _emailNotifier.value = value;
              if (value.isNotEmpty) {
                _errorNotifier.value = '';
              }
            },
            validateValue: _emailValidator,
          ),
        ));
  }

  String? _emailValidator(String? value) {
    // Check if the email is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    // Regular expression pattern for email validation
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; // Standard email pattern
    RegExp regExp = RegExp(pattern);
    // Check if the email matches the pattern
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    // Return null if the email is valid
    return null;
  }

  _closeKeyboard(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus(); // Close the keyboard
    }
  }

  void _onResetTapped(BuildContext context, WidgetRef ref) async {
    if (_emailNotifier.value.isNotEmpty) {
      // close keyboard
      _closeKeyboard(context);
      _errorNotifier.value = '';
      // Call the reset password method from the provider
      final authNotifier = ref.watch(authProvider.notifier);
      String email = _emailNotifier.value;
      await authNotifier.resetPassword(
        email,
        () => _widgetNotifier.value = 1,
        (error) {
          _widgetNotifier.value = 2;
          _errorNotifier.value = error.toString();
        },
      );
    } else {
      _errorNotifier.value = 'Please enter your email!';
    }
  }

  _errorWidget(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _errorNotifier,
      builder: (context, value, child) {
        return LWPopupLayout(
          title: 'Reset Password',
          message:
              'Failed to send password reset email to ${_emailNotifier.value}. Please ensure the email is correct and try again. (Error: $value)',
          duration: Duration(milliseconds: 300),
          backgroundColor: const Color.fromARGB(255, 163, 249, 240),
          borderColor: kBlack,
          rightButton: LWPopupLayoutButtons(
            label: 'Try Again',
            iconData: FontAwesomeIcons.arrowsRotate,
            onTap: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }
}
