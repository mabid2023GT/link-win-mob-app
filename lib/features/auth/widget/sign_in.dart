import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/widgets/link_win_text_field_widget.dart';

class SignIn extends ConsumerWidget {
  final Size size;
  const SignIn({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size txtFieldSize = Size(size.width, size.height * 0.15);

    return Scaffold(
      backgroundColor: transparent,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _emailField(txtFieldSize),
            SizedBox(
              height: size.height * 0.05,
            ),
            _passwordField(txtFieldSize),
          ],
        ),
      ),
    );
  }

  _textFieldWrapper({
    required Size size,
    required String label,
    required String hint,
    required IconData iconData,
    required void Function(String) onChanged,
    required String? Function(String)? validateValue,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) =>
      Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.2),
        ),
        child: LWTextFieldWidget(
          label: label,
          hint: hint,
          icon: iconData,
          borderRadiusRatio: 0.1,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          validateValue: validateValue,
        ),
      );

  _emailField(Size txtFieldSize) {
    return _textFieldWrapper(
      size: txtFieldSize,
      label: 'Email',
      hint: 'Enter your email',
      iconData: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validateValue: (val) {},
      onChanged: (val) {},
    );
  }

  _passwordField(Size txtFieldSize) {
    return _textFieldWrapper(
      size: txtFieldSize,
      label: 'Password',
      hint: 'Enter your password',
      iconData: Icons.password,
      obscureText: true,
      validateValue: (val) {},
      onChanged: (val) {},
    );
  }
}
