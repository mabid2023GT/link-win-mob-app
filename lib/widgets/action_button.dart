import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class ActionButton extends StatelessWidget {
  final BuildContext context;
  final String svgPath;
  final bool isClicked;
  final Color activeColor;
  final Color inactiveColor;
  final Color labelColor;
  final String? actionLabel;
  final double? lableFontSize;
  final bool isFullScreenChild;
  const ActionButton({
    super.key,
    required this.context,
    required this.svgPath,
    required this.isClicked,
    this.activeColor = kBlue,
    this.inactiveColor = kBlack,
    this.labelColor = kWhite,
    this.actionLabel,
    this.lableFontSize = 10.0,
    this.isFullScreenChild = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        double iconSize = maxSize.height * 0.55;
        return actionLabel != null
            ? Column(
                children: [
                  _svgIcon(iconSize),
                  _svgLabel(context, actionLabel!),
                ],
              )
            : _svgMoreHoriIcon(iconSize);
      },
    );
  }

  Text _svgLabel(BuildContext context, String actionLabel) {
    TextStyle? style = Theme.of(context).textTheme.labelSmall;
    if (lableFontSize != null) {
      style = style!.copyWith(
        fontSize: lableFontSize,
        fontWeight: FontWeight.bold,
        color: labelColor,
      );
    }
    return Text(
      actionLabel,
      textAlign: TextAlign.center,
      style: style,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _svgIcon(double iconSize) {
    return SvgPicture.asset(
      svgPath,
      width: iconSize,
      height: iconSize,
      colorFilter: ColorFilter.mode(
        isClicked ? activeColor : inactiveColor,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _svgMoreHoriIcon(double iconSize) {
    return Container(
      width: iconSize,
      height: iconSize,
      padding: EdgeInsets.all(iconSize * 0.3),
      child: SvgPicture.asset(
        svgPath,
        colorFilter: ColorFilter.mode(
          isClicked ? activeColor : inactiveColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
