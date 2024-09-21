import 'package:flutter/material.dart';

class LWTextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  // final ValueChanged<String> onChanged;
  // final String? Function(String)? validateValue;
  final TextInputType? keyboardType;

  const LWTextFieldWidget({
    Key? key,
    required this.label,
    required this.text,
    // required this.onChanged,
    // required this.validateValue,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<LWTextFieldWidget> createState() => _LWTextFieldWidgetState();
}

class _LWTextFieldWidgetState extends State<LWTextFieldWidget> {
  late final TextEditingController controller;
  String? errorText;

  @override
  void initState() {
    super.initState();
    errorText = null;
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  // void validateValue(String value) {
  //   widget.onChanged(value);
  //   if (widget.validateValue != null) {
  //     setState(() {
  //       errorText = widget.validateValue!(value);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorText: errorText),
            validator: (value) => errorText,
            // onChanged: validateValue,
          ),
        ],
      );
}
