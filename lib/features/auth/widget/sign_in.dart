import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/providers/auth/auth_provider.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:link_win_mob_app/widgets/popups/modal_bottom_sheet.dart';

class SignIn extends ConsumerStatefulWidget {
  final Size size;
  const SignIn({
    super.key,
    required this.size,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _obscuredNotifier = ValueNotifier(true);

  String _email = '';
  String _password = '';
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size txtFieldSize = Size(widget.size.width, widget.size.height * 0.15);
    Size signInSize = Size(widget.size.width * 0.4, widget.size.height * 0.15);

    return Scaffold(
      backgroundColor: transparent,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _emailField(txtFieldSize),
              _space(),
              _passwordField(txtFieldSize),
              _space(),
              _forgotPassword(txtFieldSize),
              _space(),
              _signIn(signInSize),
            ],
          ),
        ),
      ),
    );
  }

  _space() {
    return SizedBox(
      height: widget.size.height * 0.05,
    );
  }

  _textFieldWrapper({
    required Size size,
    required String label,
    required String hint,
    required IconData iconData,
    required FocusNode focusNode,
    required void Function(String) onChanged,
    required String? Function(String?)? validator,
    bool obscureText = false,
    bool isPasswordField = false,
    TextInputType? keyboardType,
  }) {
    double iconSize = size.height * 0.3;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.2),
      ),
      child: TextFormField(
        focusNode: focusNode,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          label: Text(
            label,
            style: TextStyle(),
          ),
          labelStyle: TextStyle(),
          hintText: hint,
          hintStyle: TextStyle(),
          prefixIcon: Icon(
            iconData,
            size: iconSize,
          ),
          suffixIcon: isPasswordField ? _suffixIcon(iconSize) : null,
        ),
      ),
    );
  }

  _suffixIcon(double iconSize) {
    return ValueListenableBuilder(
      valueListenable: _obscuredNotifier,
      builder: (context, isObscured, child) => LinkWinIcon(
        iconSize: Size(iconSize, iconSize),
        iconColor: kBlack,
        iconData: isObscured ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
        iconSizeRatio: 0.7,
        splashColor: kHeaderColor,
        onTap: () => _obscuredNotifier.value = !isObscured,
      ),
    );
  }

  _emailField(Size txtFieldSize) {
    return _textFieldWrapper(
      size: txtFieldSize,
      label: 'Email',
      hint: 'Enter your email',
      iconData: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (val) => _validateRegularText(val, 'Please enter email'),
      onChanged: (val) => _email = val,
      focusNode: _emailFocusNode,
    );
  }

  _passwordField(Size txtFieldSize) {
    return ValueListenableBuilder(
      valueListenable: _obscuredNotifier,
      builder: (context, isObscured, child) => _textFieldWrapper(
        size: txtFieldSize,
        label: 'Password',
        hint: 'Enter your password',
        iconData: Icons.password,
        obscureText: isObscured,
        isPasswordField: true,
        validator: (val) => _validateRegularText(val, 'Please enter password'),
        onChanged: (val) => _password = val,
        focusNode: _passwordFocusNode,
      ),
    );
  }

  _forgotPassword(Size size) {
    return InkWell(
      onTap: () => showResetPasswordPopup(context),
      child: Container(
        width: size.width,
        height: size.height,
        alignment: AlignmentDirectional.center,
        child: Text(
          'Forgot your password?',
          style: TextStyle(
            fontSize: 18,
            color: kBlue,
            fontWeight: FontWeight.w400,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }

  _signIn(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ElevatedButton(
        onPressed: _signInTapped,
        style: ElevatedButton.styleFrom(
          backgroundColor: kHeaderColor,
        ),
        child: Text(
          'Sign In',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kBlack,
          ),
        ),
      ),
    );
  }

  String? _validateRegularText(String? val, String errorMessage) {
    if (val == null || val.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  _signInTapped() {
    if (_formKey.currentState!.validate() &&
        !(_email.isEmpty || _password.isEmpty)) {
      _closeKeyboard(context);
      // Wait until the keyboard is fully dismissed before continuing
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          // Make sure the keyboard is fully dismissed before navigation
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              // show popup
              showSignInPopup(context);
              // call singin method
              ref.read(authProvider).signIn(
                _email,
                _password,
                () {
                  // Dismiss the loading popup if form validation fails
                  Navigator.of(context).pop();
                  // go to home page after authentication
                  context.go('/home');
                  // check if need to verified email
                  ref.read(authProvider).handleUnverifiedUser(
                        () => showVerificationEmailPopup(context),
                        () => Navigator.of(context).pop(),
                      );
                },
                (error) {},
              );
            },
          );
        },
      );
    }
  }

  _closeKeyboard(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus(); // Close the keyboard
    }
    // Unfocus both the email and password FocusNodes
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }
}
