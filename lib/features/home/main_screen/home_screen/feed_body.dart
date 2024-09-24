import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/features/home/main_screen/post/feed_post.dart';
import 'package:link_win_mob_app/providers/home/feed_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class FeedBody extends ConsumerWidget {
  const FeedBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(feedProvider);

    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size seperatorSize = Size(maxSize.width, maxSize.height * 0.03);
        return SizedBox(
          width: maxSize.width,
          height: maxSize.height,
          child: PageView.builder(
            itemCount: feed.length,
            itemBuilder: (context, pageIndex) {
              final page = feed[pageIndex];
              return ListView.separated(
                itemCount: page!.posts.length,
                itemBuilder: (context, postIndex) {
                  final post = page.posts[postIndex];
                  post.copyWith(pageIndex: pageIndex);
                  return _postContainer(
                    size: maxSize,
                    child: FeedPost(
                      pageIndex: post.pageIndex,
                      postId: post.postId,
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  width: seperatorSize.width,
                  height: seperatorSize.height,
                ),
              );
            },
          ),
        );
      },
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
