import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';

class FullScreenPostAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Size appbarSize;
  final ValueNotifier<int> currentIndexNotifier;
  final int totalItems;
  final Color backgroundColor;
  const FullScreenPostAppBar({
    super.key,
    required this.currentIndexNotifier,
    required this.totalItems,
    required this.appbarSize,
    this.backgroundColor = kBlack,
  });

  @override
  Widget build(BuildContext context) {
    double rightPadding = appbarSize.width * 0.05;
    return AppBar(
      backgroundColor: backgroundColor,
      leading: Container(),
      centerTitle: true,
      title: ValueListenableBuilder(
        valueListenable: currentIndexNotifier,
        builder: (context, value, child) => Text(
          '${value + 1} of $totalItems',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 14.0,
                color: kWhite,
              ),
        ),
      ),
      actions: [
        _closeButton(context, appbarSize.height * 0.7),
        SizedBox(
          width: rightPadding,
        ),
      ],
    );
  }

  Widget _closeButton(BuildContext context, double iconSize) {
    return LinkWinIcon(
      iconSize: Size(iconSize, iconSize),
      splashColor: k1Gray,
      backgroundColor: k1Gray.withOpacity(0.75),
      iconData: Icons.close,
      iconSizeRatio: 0.8,
      iconColor: kWhite,
      onTap: () => Navigator.of(context).pop(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appbarSize.height);
}
