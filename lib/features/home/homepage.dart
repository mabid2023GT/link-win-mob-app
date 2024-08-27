import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen.dart';
import 'package:link_win_mob_app/features/home/nav/nav.dart';
import 'package:link_win_mob_app/features/home/nav/nav_floating_action_button.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _pages = [
    const HomeScreen(),
    LayoutBuilderChild(
      child: (minSize, maxSize) => Container(
        alignment: Alignment.center,
        child: Text(maxSize.toString()),
      ),
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('Fav List'),
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('Profile'),
    ),
  ];

  _changePageTo(int index) {
    setState(() => _selectedIndex = index);
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
