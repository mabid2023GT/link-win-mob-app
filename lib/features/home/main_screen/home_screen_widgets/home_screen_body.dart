import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/features/home/main_screen/post_widgets/home_screen_post.dart';
import 'package:link_win_mob_app/providers/home/post_feed_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class HomeScreenBody extends ConsumerWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postStates = ref.watch(postFeedProvider);

    return LayoutBuilderChild(
      child: (minSize, maxSize) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...postStates.map<Widget>(
              (postState) {
                return _postContainer(
                  size: maxSize,
                  child: HomeScreenPost(
                    postState: postState,
                  ),
                );
              },
            ).toList(),
            SizedBox(
              height: maxSize.height * 0.1,
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
