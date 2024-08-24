import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/responsive_ui_tools/errors/responsive_ui_error.dart';

class ResponsivePercentageLayout extends StatelessWidget {
  final Size size;
  final ScreenUtil screenUtil;
  final bool isRow;
  final List<int> percentages;
  final List<Widget> children;
  ResponsivePercentageLayout({
    super.key,
    required this.size,
    required this.screenUtil,
    required this.isRow,
    required this.percentages,
    required this.children,
  }) {
    validateInputs();
  }

  @override
  Widget build(BuildContext context) {
    return isRow ? buildRow(context) : buildColumn(context);
  }

  buildRow(BuildContext context) {
    return Row(
      children: List.generate(
        children.length,
        (index) {
          return SizedBox(
            width: screenUtil.widthFromParentPercentage(
              percentages[index].toDouble(),
              size.width,
            ),
            child: children[index],
          );
        },
      ),
    );
  }

  buildColumn(BuildContext context) {
    return Column(
      children: List.generate(
        children.length,
        (index) {
          return SizedBox(
            height: screenUtil.heightFromParentPercentage(
              percentages[index].toDouble(),
              size.height,
            ),
            child: children[index],
          );
        },
      ),
    );
  }

  void validateInputs() {
    validateSizeInputs();
    validateListInputs();
  }

  void validateSizeInputs() {
    if (size.width > screenUtil.screenWidth) {
      throw ResponsiveUIError(
        "The given width (size.width) exceeds the screen width (size.width: ${size.width} <--> screenWidth: ${screenUtil.screenWidth}).",
      );
    } else if (size.width <= 0) {
      throw ResponsiveUIError(
        "The given width (size.width) cannot be negative or zero.",
      );
    }

    if (size.height > screenUtil.screenHeight) {
      throw ResponsiveUIError(
        "The given height (size.height) exceeds the screen height (size.height: ${size.height} <--> screenHeight: ${screenUtil.screenHeight}).",
      );
    } else if (size.height <= 0) {
      throw ResponsiveUIError(
        "The given height (size.height) cannot be negative or zero.",
      );
    }
  }

  void validateListInputs() {
    if (percentages.length != children.length) {
      throw ResponsiveUIError(
        "The length of percentagesList should match the length of the children list (percentagesList.length: ${percentages.length} != ${children.length} :children.length)",
      );
    }

    // Validate that each percentage is within the range 1 to 100
    for (int percentage in percentages) {
      if (percentage < 1 || percentage > 100) {
        throw ResponsiveUIError(
            "Each percentage value ($percentage) must be between 1 and 100.");
      }
    }

    final totalPercentage = percentages.fold(0.0, (sum, p) => sum + p);
    if (totalPercentage > 100) {
      throw ResponsiveUIError(
        "The total percentage ($totalPercentage%) exceeds 100%.",
      );
    } else if (totalPercentage < 100) {
      throw ResponsiveUIError(
        "The total percentage ($totalPercentage%) is less than 100%.",
      );
    }
  }
}
