import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/features/home/employment_hub/employment_hub.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen.dart';
import 'package:link_win_mob_app/features/home/nav/nav.dart';
import 'package:link_win_mob_app/features/home/nav/nav_floating_action_button.dart';
import 'package:link_win_mob_app/features/home/profile/profile_screen.dart';
import 'package:link_win_mob_app/features/home/service_providers/service_providers.dart';
import 'package:link_win_mob_app/providers/auth/auth_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/popups/modal_bottom_sheet.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  final _pages = [
    const HomeScreen(),
    const ServiceProviders(),
    const EmploymentHub(),
    const ProfileScreen(),
  ];

  _changePageTo(int index) {
    setState(() => _selectedIndex = index);
  }

  _handleUnverifiedUser() {
    // Show the verify email popup
    ref.read(authProvider).handleUnverifiedUser(
          () => showVerificationEmailPopup(context),
          () => Navigator.of(context).pop(),
        );
  }

  @override
  void initState() {
    super.initState();
    _handleUnverifiedUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size bottomNavBarSize = Size(maxSize.width, maxSize.height * 0.1);
        return Scaffold(
          backgroundColor: kWhite,
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          floatingActionButton: NavFloatingActionButton(
            iconPath: _fetchFloatingActionButtonIcon(),
            bottomNavBarSize: bottomNavBarSize,
            onTap: () {},
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: HomeNav(
            size: bottomNavBarSize,
            changePageTo: _changePageTo,
            selectedIndex: _selectedIndex,
          ),
        );
      },
    );
  }

  _fetchFloatingActionButtonIcon() {
    return _selectedIndex == 3
        ? 'assets/icons/settings.svg'
        : 'assets/icons/plus.svg';
  }
}
