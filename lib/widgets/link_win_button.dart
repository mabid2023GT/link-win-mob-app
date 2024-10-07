import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';

class LinkWinButton extends StatefulWidget {
  final String label;
  final IconData iconData;
  final Size buttonSize;
  final Color borderColor;
  final Color backgroundColor;
  final Color splashColor;
  final VoidCallback onTap;
  const LinkWinButton({
    super.key,
    required this.label,
    required this.iconData,
    required this.buttonSize,
    required this.onTap,
    this.borderColor = kBlack,
    this.backgroundColor = kWhite,
    this.splashColor = kHeaderColor,
  });

  @override
  State<LinkWinButton> createState() => _LinkWinButtonState();
}

class _LinkWinButtonState extends State<LinkWinButton> {
  @override
  Widget build(BuildContext context) {
    double bordeRadius = widget.buttonSize.width * 0.05;
    return Material(
      color: transparent,
      child: InkWell(
        splashColor: widget.splashColor,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            bordeRadius,
          ),
        ),
        child: _container(),
        onTap: widget.onTap,
      ),
    );
  }

  _container() {
    return Container(
      width: widget.buttonSize.width,
      height: widget.buttonSize.height,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.buttonSize.width * 0.4),
        border: Border.all(
          width: 2,
          color: widget.borderColor,
        ),
      ),
      child: _body(),
    );
  }

  _body() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          widget.iconData,
          size: widget.buttonSize.height * 0.4,
        ),
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            color: widget.borderColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
