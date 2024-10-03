import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class LWTextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String? Function(String)? validateValue;
  final TextInputType? keyboardType;

  const LWTextFieldWidget({
    super.key,
    required this.label,
    required this.text,
    required this.icon,
    required this.onChanged,
    required this.validateValue,
    this.keyboardType = TextInputType.text,
  });

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

  void validateValue(String value) {
    widget.onChanged(value);
    if (widget.validateValue != null) {
      setState(() {
        errorText = widget.validateValue!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) =>
      LayoutBuilderChild(child: (minSize, maxSize) {
        return SizedBox(
          width: maxSize.width,
          height: maxSize.height,
          child: TextFormField(
            style: const TextStyle(fontSize: 12),
            controller: controller,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
                prefixIcon: Icon(widget.icon,
                    color: kBlack, size: maxSize.height * 0.5),
                labelText: widget.label,
                labelStyle: const TextStyle(
                    color: kBlack, fontSize: 10, fontWeight: FontWeight.bold),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: kBlack, width: 2),
                ),
                filled: true,
                fillColor: Colors.amber,
                contentPadding: EdgeInsets.symmetric(
                  vertical: maxSize.height * 0.2,
                  horizontal: 0.0,
                ),
                errorText: errorText),
            validator: (value) => errorText,
            onChanged: validateValue,
          ),
        );
      });
}
