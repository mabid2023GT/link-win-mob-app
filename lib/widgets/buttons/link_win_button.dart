import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class LWButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? iconData;
  final Color fontColor;
  final Color iconColor;
  final Color? splashColor;
  final Color bgColor;
  final Color borderColor;
  final double borderWidth;
  const LWButton({
    super.key,
    required this.label,
    required this.onTap,
    this.iconData,
    this.fontColor = kBlack,
    this.iconColor = kBlack,
    this.splashColor,
    this.bgColor = kHeaderColor,
    this.borderColor = kBlack,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        BorderRadius borderRadius = BorderRadius.circular(maxSize.width * 0.2);
        double iconSize = maxSize.height * 0.6;
        return Container(
          width: maxSize.width,
          height: maxSize.height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: borderRadius,
            border: Border.all(
              width: borderWidth,
              color: borderColor,
            ),
          ),
          child: _buttonBox(borderRadius, iconSize),
        );
      },
    );
  }

  _buttonBox(
    BorderRadius borderRadius,
    double iconSize,
  ) {
    return Material(
      color: transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        splashColor: splashColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (iconData != null) _iconWidget(iconSize),
            _labelWidget()
          ],
        ),
      ),
    );
  }

  Text _labelWidget() {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16,
        color: fontColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lato',
      ),
    );
  }

  Icon _iconWidget(double iconSize) {
    return Icon(
      iconData,
      size: iconSize,
      color: iconColor,
    );
  }
}
