import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';

class LWTextFieldWidget extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String? Function(String)? validateValue;
  final TextInputType? keyboardType;
  final Color fillColor;
  final double fontSize;
  final double borderRadiusRatio;
  final double iconSizeRatio;
  final bool obscureText;

  const LWTextFieldWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.onChanged,
    required this.validateValue,
    this.keyboardType = TextInputType.text,
    this.fillColor = kHeaderColor,
    this.fontSize = 14,
    this.borderRadiusRatio = 0.05,
    this.iconSizeRatio = 0.3,
    this.obscureText = false,
  });

  @override
  State<LWTextFieldWidget> createState() => _LWTextFieldWidgetState();
}

class _LWTextFieldWidgetState extends State<LWTextFieldWidget> {
  late final TextEditingController controller;
  String? errorText;
  // State variable for password visibility
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    errorText = null;
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void validateValue(String value) {
    widget.onChanged(value);
    if (widget.validateValue != null) {
      setState(() {
        errorText = widget.validateValue!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        double leftRightPad = maxSize.width * 0.05;
        return Container(
          width: maxSize.width,
          height: maxSize.height,
          alignment: AlignmentDirectional.center,
          padding: EdgeInsets.only(
            left: leftRightPad,
            right: leftRightPad,
          ),
          decoration: BoxDecoration(
            color: widget.fillColor,
            borderRadius: BorderRadius.circular(
              maxSize.width * widget.borderRadiusRatio,
            ),
          ),
          child: _textFieldWidget(maxSize),
        );
      },
    );
  }

  _textFieldWidget(Size maxSize) {
    return TextFormField(
      style: TextStyle(fontSize: widget.fontSize),
      controller: controller,
      keyboardType: widget.keyboardType,
      decoration: _inputDecoration(maxSize),
      validator: (value) => errorText,
      onChanged: validateValue,
      // Disable autocorrect and suggestions
      autocorrect: false,
      enableSuggestions: false,
      enableInteractiveSelection: false,
      obscureText: _isObscured ? widget.obscureText : false,
    );
  }

  _inputDecoration(Size maxSize) {
    double iconSize = maxSize.height * widget.iconSizeRatio;
    return InputDecoration(
      prefixIcon: Icon(widget.icon, color: kBlack, size: iconSize),
      suffixIcon: widget.obscureText ? _suffixIcon(iconSize) : null,
      label: Text(widget.label),
      labelStyle: TextStyle(
        color: k1Gray,
        fontSize: widget.fontSize,
        fontWeight: FontWeight.bold,
      ),
      hintText: widget.hint,
      hintStyle: TextStyle(
        color: k1Gray,
        fontSize: widget.fontSize,
      ),
      // Apply underline below text (not under the icon)
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kBlack, width: 1),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kBlack, width: 1),
      ),
      errorText: errorText,
    );
  }

  _suffixIcon(double iconSize) {
    return LinkWinIcon(
      iconSize: Size(iconSize, iconSize),
      iconColor: kBlack,
      iconData: _isObscured ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
      iconSizeRatio: 0.7,
      splashColor: kSelectedTabColor,
      onTap: () {
        setState(() {
          _isObscured = !_isObscured;
        });
      },
    );
  }
}
