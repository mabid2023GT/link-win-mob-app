import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/full_screen_media_type.dart';
import 'package:link_win_mob_app/core/utils/enums/home_screen_post_type.dart';
import 'package:link_win_mob_app/features/home/main_screen/post_widgets/gallery_content_viewer.dart';
import 'package:link_win_mob_app/features/home/main_screen/post_widgets/video_content_viewer.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/full_screen_post.dart';

class HomeScreenPostBody extends StatelessWidget {
  final double borderRadiusPercentage;
  final HomeScreenPostData homeScreenPostData;
  const HomeScreenPostBody({
    super.key,
    required this.borderRadiusPercentage,
    required this.homeScreenPostData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(child: (minSize, maxSize) {
      BorderRadius contentBorderRadius = BorderRadius.only(
        topLeft: Radius.circular(
          maxSize.width * borderRadiusPercentage * 0.9,
        ),
        topRight: Radius.circular(
          maxSize.width * borderRadiusPercentage * 0.9,
        ),
      );
      return Container(
        width: maxSize.width,
        height: maxSize.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              maxSize.width * borderRadiusPercentage,
            ),
            topRight: Radius.circular(
              maxSize.width * borderRadiusPercentage,
            ),
          ),
        ),
        child: _buildContentViewer(context, maxSize, contentBorderRadius),
      );
    });
  }

  _buildContentViewer(
      BuildContext context, Size maxSize, BorderRadius contentBorderRadius) {
    switch (homeScreenPostData.homeScreenPostType) {
      case HomeScreenPostType.image:
        return _buildImageContentViewer(context, maxSize, contentBorderRadius);
      case HomeScreenPostType.imageCollection:
        return GalleryContentViewer(
          contentBorderRadius: contentBorderRadius,
          homeScreenPostData: homeScreenPostData,
        );
      case HomeScreenPostType.video:
        return VideoContentViewer(
          contentBorderRadius: contentBorderRadius,
          homeScreenPostData: homeScreenPostData,
          url: homeScreenPostData.content[0],
        );
      case HomeScreenPostType.videoCollection:
        return VideosContentViewer(
          contentBorderRadius: contentBorderRadius,
          homeScreenPostData: homeScreenPostData,
        );
      case HomeScreenPostType.text:
        return Container(
          color: Colors.purple,
        );
    }
  }

  _buildImageContentViewer(
      BuildContext context, Size maxSize, BorderRadius contentBorderRadius) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenPost(
              fullScreenMediaType: FullScreenMediaType.image,
              homeScreenPostData: homeScreenPostData,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: contentBorderRadius,
        child: Image.network(
          homeScreenPostData.content[0],
          width: maxSize.width,
          height: maxSize.height,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
