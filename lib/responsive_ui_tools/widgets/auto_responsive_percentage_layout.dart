import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/responsive_percentage_layout.dart';

class AutoResponsivePercentageLayout extends StatelessWidget {
  final ScreenUtil screenUtil;
  final bool isRow;
  final List<int> percentages;
  final List<Widget> children;
  const AutoResponsivePercentageLayout({
    super.key,
    required this.screenUtil,
    required this.isRow,
    required this.percentages,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => ResponsivePercentageLayout(
        size: maxSize,
        screenUtil: screenUtil,
        isRow: isRow,
        percentages: percentages,
        children: children,
      ),
    );
  }
}
