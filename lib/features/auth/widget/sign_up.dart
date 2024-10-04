import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_text_field_widget.dart';

class SignUp extends ConsumerWidget {
  final Size size;
  const SignUp({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size txtFieldSize = Size(size.width, size.height * 0.15);
    Size signInSize = Size(size.width * 0.4, size.height * 0.15);

    return Scaffold(
      backgroundColor: transparent,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _firstNameField(txtFieldSize),
            _space(),
            _lastNameField(txtFieldSize),
            _space(),
            _phoneField(txtFieldSize),
            _space(),
            _emailField(txtFieldSize),
            _space(),
            _passwordField(txtFieldSize),
            _space(),
            _termsAndConditions(txtFieldSize),
            _space(),
            _signUp(signInSize)
          ],
        ),
      ),
    );
  }

  _space() {
    return SizedBox(
      height: size.height * 0.05,
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

  _firstNameField(Size txtFieldSize) {
    return _textFieldWrapper(
      size: txtFieldSize,
      label: 'Firstname',
      hint: 'Enter your firstname',
      iconData: FontAwesomeIcons.user,
      validateValue: (val) {},
      onChanged: (val) {},
    );
  }

  _lastNameField(Size txtFieldSize) {
    return _textFieldWrapper(
      size: txtFieldSize,
      label: 'Lastname',
      hint: 'Enter your lastname',
      iconData: Icons.family_restroom,
      validateValue: (val) {},
      onChanged: (val) {},
    );
  }

  _phoneField(Size txtFieldSize) {
    return _textFieldWrapper(
      size: txtFieldSize,
      label: 'Phone',
      hint: 'Enter your phone number',
      iconData: FontAwesomeIcons.mobileScreenButton,
      keyboardType: TextInputType.phone,
      validateValue: (val) {},
      onChanged: (val) {},
    );
  }

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

  _signUp(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: kHeaderColor,
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kBlack,
          ),
        ),
      ),
    );
  }

  _termsAndConditions(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: _TermsAndConditions(),
    );
  }
}

class _TermsAndConditions extends StatefulWidget {
  const _TermsAndConditions();

  @override
  State<_TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<_TermsAndConditions> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size checkBoxSize = Size(maxSize.width * 0.1, maxSize.height);
        double space = maxSize.width * 0.1;
        Size labelSize =
            Size(maxSize.width - checkBoxSize.width - space, maxSize.height);
        return SizedBox(
          width: maxSize.width,
          height: maxSize.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: checkBoxSize.width,
                height: checkBoxSize.height,
                child: _checkBox(),
              ),
              Container(
                width: labelSize.width,
                height: labelSize.height,
                alignment: AlignmentDirectional.center,
                child: _termsAndConditions(),
              ),
            ],
          ),
        );
      },
    );
  }

  _checkBox() {
    return Checkbox(
      value: _isChecked,
      onChanged: (bool? newValue) {
        setState(
          () {
            _isChecked = newValue ?? false;
          },
        );
      },
    );
  }

  _termsAndConditions() {
    return Expanded(
      child: RichText(
        // Ensure the text wraps
        softWrap: true,
        text: TextSpan(
          // Adding space between lines globally
          style: TextStyle(
            height: 1.5,
            fontSize: 16,
          ),
          children: [
            _blackText('I accept the '),
            _blueText('Terms & Conditions', () {}),
            _blackText(' and '),
            _blueText('Privacy Policy', () {}),
            _blackText('.'),
          ],
        ),
      ),
    );
  }

  _blackText(String text) => TextSpan(
        text: text,
        style: TextStyle(
          color: kBlack,
        ),
      );

  _blueText(String text, VoidCallback onTap) => TextSpan(
        text: text,
        style: TextStyle(
          color: kBlue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()..onTap = onTap,
      );
}
