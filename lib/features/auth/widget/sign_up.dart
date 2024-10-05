import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';

class SignUp extends ConsumerStatefulWidget {
  final Size size;
  const SignUp({
    super.key,
    required this.size,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _obscuredNotifier = ValueNotifier(true);
  final ValueNotifier<bool> _isFormSubmittedNotifier = ValueNotifier(false);
  late final Map<String, dynamic> _formValues;

  @override
  void initState() {
    super.initState();
    _formValues = _initValuesMap();
  }

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

  _firstNameField(Size txtFieldSize) {
    return _textFieldWrapper(
      size: txtFieldSize,
      label: 'Firstname',
      hint: 'Enter your firstname',
      iconData: FontAwesomeIcons.user,
      validator: (val) =>
          _validateRegularText(val, 'Please enter your firstname'),
      onChanged: (val) => _updateValuesMap('firstname', val),
    );
  }

  _lastNameField(Size txtFieldSize) {
    return _textFieldWrapper(
      size: txtFieldSize,
      label: 'Lastname',
      hint: 'Enter your lastname',
      iconData: Icons.family_restroom,
      validator: (val) =>
          _validateRegularText(val, 'Please enter your lastname'),
      onChanged: (val) => _updateValuesMap('lastname', val),
    );
  }

  _phoneField(Size txtFieldSize) {
    return _textFieldWrapper(
      size: txtFieldSize,
      label: 'Phone',
      hint: 'Enter your phone number',
      iconData: FontAwesomeIcons.mobileScreenButton,
      keyboardType: TextInputType.phone,
      validator: _validatePhoneNumber,
      onChanged: (val) => _updateValuesMap('phone', val),
    );
  }

  _emailField(Size txtFieldSize) {
    return _textFieldWrapper(
      size: txtFieldSize,
      label: 'Email',
      hint: 'Enter your email',
      iconData: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: _emailValidator,
      onChanged: (val) => _updateValuesMap('email', val),
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
        validator: passwordValidator,
        onChanged: (val) => _updateValuesMap('password', val),
      ),
    );
  }

  _signUp(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ElevatedButton(
        onPressed: _onSignUpTapped,
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
    return _TermsAndConditions(
      size: size,
      onChanged: (isChecked) => _updateValuesMap('t&c', isChecked),
      isFormSubmittedNotifier: _isFormSubmittedNotifier,
    );
  }

  String? _validateRegularText(String? val, String errorMessage) {
    if (val == null || val.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    // Check if the phone number is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // Check if the phone number starts with '05'
    if (!value.startsWith('05')) {
      return 'Phone number must start with 05';
    }
    // Check if the phone number is exactly 10 digits
    if (value.length != 10 || !RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Phone number must be 10 digits';
    }
    // Return null if the phone number is valid
    return null;
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

  String? passwordValidator(String? value) {
    // Check if the password is empty
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    }
    // Check if the password length is between 8 and 20 characters
    if (value.length < 8) {
      return 'Min 8 characters';
    } else if (value.length > 20) {
      return 'Max 20 characters';
    }
    // Check if the password contains at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Include at least 1 uppercase letter';
    }
    // Check if the password contains at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Include at least 1 lowercase letter';
    }
    // Check if the password contains at least one digit
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Include at least 1 digit';
    }
    // Check if the password contains at least one special character
    if (!RegExp(r'[!@#$%^&*]').hasMatch(value)) {
      return 'Include 1 special character';
    }
    // Return null if the password is valid
    return null;
  }

  _onSignUpTapped() {
    // Update the notifier to display the error message only when the checkbox
    // is unchecked; if the notifier value is false, the error message
    // will not be shown, even if the checkbox remains unchecked.
    _isFormSubmittedNotifier.value = true;
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate() && _formValues['t&c']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Valid Form'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Form'),
        ),
      );
    }
  }

  Map<String, dynamic> _initValuesMap() {
    return {
      'firstname': '',
      'lastname': '',
      'phone': '',
      'email': '',
      'password': '',
      't&c': false,
    };
  }

  void _updateValuesMap(String key, dynamic val) => _formValues[key] = val;
}

class _TermsAndConditions extends StatefulWidget {
  final void Function(bool?) onChanged; // Callback to notify the parent
  final Size size;
  final ValueNotifier<bool> isFormSubmittedNotifier;
  const _TermsAndConditions({
    required this.onChanged,
    required this.size,
    required this.isFormSubmittedNotifier,
  });

  @override
  State<_TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<_TermsAndConditions> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    Size checkBoxSize = Size(widget.size.width * 0.1, widget.size.height);
    double space = widget.size.width * 0.2;
    Size labelSize = Size(
        widget.size.width - checkBoxSize.width - space, widget.size.height);
    return SizedBox(
      width: widget.size.width,
      height: !_isChecked ? 2 * widget.size.height : widget.size.height,
      child: Column(
        children: [
          _tAndcWidget(checkBoxSize, labelSize),
          _errorMessageWidget(space, checkBoxSize),
        ],
      ),
    );
  }

  _tAndcWidget(Size checkBoxSize, Size labelSize) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
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
  }

  _errorMessageWidget(double space, Size checkBoxSize) {
    return ValueListenableBuilder(
      valueListenable: widget.isFormSubmittedNotifier,
      builder: (context, value, child) => Visibility(
        visible: value && !_isChecked,
        child: Container(
          width: widget.size.width - space - checkBoxSize.width,
          height: widget.size.height * 0.5,
          alignment: AlignmentDirectional.center,
          child: Text(
            '* You must accept the terms and conditions',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  _checkBox() {
    return Checkbox(
      value: _isChecked,
      onChanged: (bool? newValue) {
        setState(
          () {
            _isChecked = newValue ?? false;
            widget.onChanged(_isChecked);
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
