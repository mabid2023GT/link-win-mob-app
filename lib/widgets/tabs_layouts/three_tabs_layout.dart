import 'dart:math';
import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class ThreeTabsLayout extends StatelessWidget {
  final String leftTabLabel;
  final String midTabLabel;
  final String rightTabLabel;
  final IconData leftTabIcon;
  final IconData midTabIcon;
  final IconData rightTabIcon;
  final Widget leftTabView;
  final Widget midTabView;
  final Widget rightTabView;
  final ValueNotifier<int> selectedTab;
  final double tabsNavigationHeightRatio;
  const ThreeTabsLayout({
    super.key,
    required this.leftTabLabel,
    required this.midTabLabel,
    required this.rightTabLabel,
    required this.leftTabIcon,
    required this.midTabIcon,
    required this.rightTabIcon,
    required this.selectedTab,
    required this.leftTabView,
    required this.midTabView,
    required this.rightTabView,
    this.tabsNavigationHeightRatio = 0.13,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size tabsSize =
            Size(maxSize.width, maxSize.height * tabsNavigationHeightRatio);
        Size tabBodySize =
            Size(maxSize.width, maxSize.height - tabsSize.height);
        return ValueListenableBuilder(
          valueListenable: selectedTab,
          builder: (context, value, child) => Column(
            // value = 0 => left tab is selected,
            // value = 1 => mid tab is selected,
            // value = 2 => right tab is selected
            children: [
              SizedBox(
                width: tabsSize.width,
                height: tabsSize.height,
                child: _tabsNavigationWidget(),
              ),
              SizedBox(
                width: tabBodySize.width,
                height: tabBodySize.height,
                child: _tabViewWidget(),
              ),
            ],
          ),
        );
      },
    );
  }

  _tabsNavigationWidget() {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size tabSize = Size(maxSize.width * 0.29, maxSize.height);
        return _paddingContainer(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _tabWidget(
                tabSize,
                0,
              ),
              _tabWidget(tabSize, 1),
              _tabWidget(
                tabSize,
                2,
              ),
            ],
          ),
          maxSize,
          0.05,
          0.05,
        );
      },
    );
  }

  _tabWidget(Size tabSize, int index) {
    Radius radius = Radius.circular(
      min(tabSize.height * 0.7, tabSize.width * 0.5),
    );
    return InkWell(
      onTap: () => selectedTab.value = index,
      child: Container(
        width: tabSize.width,
        height: tabSize.height,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: selectedTab.value == index
              ? kSelectedTabColor
              : kUnSelectedTabColor,
          borderRadius: BorderRadius.only(
            topLeft: radius,
            bottomRight: radius,
          ),
          border: Border.all(
            color: kBlack,
            width: 2,
          ),
        ),
        child: _tabWidgetContent(index),
      ),
    );
  }

  _tabWidgetContent(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          index == 0
              ? leftTabLabel
              : index == 1
                  ? midTabLabel
                  : rightTabLabel,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Icon(
          index == 0
              ? leftTabIcon
              : index == 1
                  ? midTabIcon
                  : rightTabIcon,
        ),
      ],
    );
  }

  _tabViewWidget() {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        return _paddingContainer(
          selectedTab.value == 0
              ? leftTabView
              : selectedTab.value == 1
                  ? midTabView
                  : rightTabView,
          maxSize,
          0.05,
          0.05,
        );
      },
    );
  }

  _paddingContainer(
      Widget child, Size parentSize, double sideRatio, double topBottomRatio) {
    double topBottomPad = parentSize.height * topBottomRatio;
    double leftRightPad = parentSize.width * sideRatio;

    return Container(
      padding: EdgeInsets.only(
        left: leftRightPad,
        right: leftRightPad,
        top: topBottomPad,
        bottom: topBottomPad,
      ),
      child: child,
    );
  }
}
