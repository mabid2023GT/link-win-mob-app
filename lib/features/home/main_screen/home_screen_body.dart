import 'package:flutter/material.dart';
import 'package:link_win_mob_app/features/home/main_screen/home_screen_post.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _postContainer(
              size: maxSize,
              child: const HomeScreenPost(),
            ),
            _postContainer(
              size: maxSize,
              child: const HomeScreenPost(),
            ),
          ],
        ),
      ),
    );
  }

  _postContainer({
    required Size size,
    required Widget child,
  }) {
    return Container(
      width: size.width,
      height: size.height * 0.9,
      padding: EdgeInsets.only(
        bottom: size.height * 0.04,
        left: size.width * 0.025,
        right: size.width * 0.025,
      ),
      child: child,
    );
  }
}
