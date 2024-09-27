import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/headers/centered_title_header.dart';
import 'package:link_win_mob_app/widgets/screen_backgrounds/three_icon_background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceProviders extends StatelessWidget {
  const ServiceProviders({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);
    return ThreeIconBackground(
      firstIcon: FontAwesomeIcons.screwdriverWrench,
      secondIcon: FontAwesomeIcons.magnifyingGlassLocation,
      thirdIcon: FontAwesomeIcons.userTie,
      child: AutoResponsivePercentageLayout(
        screenUtil: screenUtil,
        isRow: false,
        percentages: const [15, 85],
        children: [
          const CenteredTitleHeader(
            title: 'Service Providers',
          ),
          _body(),
        ],
      ),
    );
  }

  _body() {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => Container(
        alignment: Alignment.center,
        child: Container(
          width: maxSize.width,
          height: maxSize.height,
          color: transparent,
          child: Text(
            maxSize.toString(),
          ),
        ),
      ),
    );
  }
}
