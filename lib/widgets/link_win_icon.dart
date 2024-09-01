import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';

class LinkWinIcon extends StatelessWidget {
  final Size iconSize;
  final double? iconSizeRatio;
  final IconData? iconData;
  final Widget? child;
  final Color splashColor;
  final Color backgroundColor;
  final Color? iconColor;
  final BoxShape shape;
  final VoidCallback? onTap;
  const LinkWinIcon({
    super.key,
    required this.iconSize,
    required this.splashColor,
    required this.onTap,
    this.iconData,
    this.child,
    this.backgroundColor = transparent,
    this.iconColor,
    this.shape = BoxShape.circle,
    this.iconSizeRatio,
  })  : assert(!(iconData != null && child != null),
            'Cannot provide both iconData and child.'),
        assert(iconData != null || child != null,
            'Either iconData or child must be provided.'),
        assert(child == null || iconSizeRatio == null,
            'iconSizeRatio must not be provided if child is used.'),
        assert(iconData == null || iconSizeRatio != null,
            'iconSizeRatio must be provided if iconData is used.'),
        assert(
            iconData == null ||
                (iconSizeRatio != null &&
                    iconSizeRatio > 0 &&
                    iconSizeRatio <= 1),
            'iconSizeRatio should be greater than 0 and less than or equal to 1 if iconData is provided.'),
        assert(child == null || iconColor == null,
            'iconColor must not be provided if child is used.'),
        assert(iconData == null || iconColor != null,
            'iconColor must be provided if iconData is used.');

  @override
  Widget build(BuildContext context) {
    return Material(
      color: transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        customBorder: shape == BoxShape.circle
            ? const CircleBorder()
            : null, // Ensure the splash is circular
        child: Container(
          width: iconSize.width,
          height: iconSize.height,
          decoration: BoxDecoration(
            shape: shape,
            color: backgroundColor,
          ),
          child: child ??
              Icon(
                iconData,
                size: iconSize.shortestSide * (iconSizeRatio ?? 0.8),
                color: iconColor ?? kWhite,
              ),
        ),
      ),
    );
  }
}
