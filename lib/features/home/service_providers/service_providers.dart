import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/providers/auth/auth_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/features/auth/widget/not_authenticated_widget.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/screen_backgrounds/three_icon_background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceProviders extends ConsumerStatefulWidget {
  const ServiceProviders({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceProvidersState();
}

class _ServiceProvidersState extends ConsumerState<ServiceProviders> {
  @override
  Widget build(BuildContext context) {
    // Listen for changes in the auth provider.
    // If the user signs out, the NotAuthenticatedWidget will be displayed
    // immediately; otherwise, the profile screen will be shown.
    final user = ref.watch(authProvider).user;
    // Check if the user is signed in
    if (user == null) {
      return NotAuthenticatedWidget();
    } else {
      ScreenUtil screenUtil = ScreenUtil(context);
      return _serviceProvider(screenUtil);
    }
  }

  _serviceProvider(ScreenUtil screenUtil) {
    return AutoResponsivePercentageLayout(
      screenUtil: screenUtil,
      isRow: false,
      percentages: const [35, 65],
      children: [
        _header(),
        _body(),
      ],
    );
  }

  _header() {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        return Container(
          width: maxSize.width,
          height: maxSize.height,
          color: Colors.amber,
        );
      },
    );
  }

  _body() {
    return ThreeIconBackground(
        firstIcon: FontAwesomeIcons.screwdriverWrench,
        secondIcon: FontAwesomeIcons.magnifyingGlassLocation,
        thirdIcon: FontAwesomeIcons.userTie,
        child: SizedBox());
  }
}
