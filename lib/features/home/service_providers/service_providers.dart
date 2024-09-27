import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/widgets/headers/centered_title_header.dart';
import 'package:link_win_mob_app/widgets/screen_backgrounds/three_icon_background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/widgets/tabs_layouts/three_tabs_layout.dart';

class ServiceProviders extends StatefulWidget {
  const ServiceProviders({super.key});

  @override
  State<ServiceProviders> createState() => _ServiceProvidersState();
}

class _ServiceProvidersState extends State<ServiceProviders> {
  final ValueNotifier<int> _selectedTabNotifier = ValueNotifier(0);

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
    return ThreeTabsLayout(
      leftTabLabel: 'Offers',
      midTabLabel: 'Active',
      rightTabLabel: 'History',
      leftTabIcon: FontAwesomeIcons.handshake,
      midTabIcon: FontAwesomeIcons.question,
      rightTabIcon: FontAwesomeIcons.clipboardCheck,
      selectedTab: _selectedTabNotifier,
      leftTabView: Container(
        color: Colors.amber.withOpacity(0.5),
      ),
      midTabView: Container(
        color: Colors.blue.withOpacity(0.5),
      ),
      rightTabView: Container(
        color: Colors.green.withOpacity(0.5),
      ),
    );
  }
}
