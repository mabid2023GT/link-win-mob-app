import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/utils/enums/home_screen_post_type.dart';
import 'package:link_win_mob_app/features/home/main_screen/post_widgets/home_screen_post.dart';
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
              child: HomeScreenPost(
                homeScreenPostData: HomeScreenPostData(
                  homeScreenPostType: HomeScreenPostType.image,
                  content: [
                    'https://img.freepik.com/free-photo/view-wild-lion-nature_23-2150460851.jpg'
                  ],
                  postId: '1234DfbdRE85',
                  actionsData: {
                    HomeScreenPostActions.comment: '40',
                    HomeScreenPostActions.support: '30 k',
                    HomeScreenPostActions.favorite: '100',
                    HomeScreenPostActions.like: '100 k',
                    HomeScreenPostActions.recommend: '20 k',
                  },
                ),
              ),
            ),
            _postContainer(
              size: maxSize,
              child: HomeScreenPost(
                homeScreenPostData: HomeScreenPostData(
                  homeScreenPostType: HomeScreenPostType.video,
                  content: [
                    'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/African%20Lion%20-%20One%20Minute%20Wildlife%20Documentary%20%23shorts.mp4?alt=media&token=4d7cd043-e484-4b46-a14b-48f9f8290e28'
                  ],
                  postId: '1234DfbdRE85',
                  actionsData: {
                    HomeScreenPostActions.comment: '50',
                    HomeScreenPostActions.support: '10 k',
                    HomeScreenPostActions.favorite: '50',
                    HomeScreenPostActions.like: '40 k',
                    HomeScreenPostActions.recommend: '',
                  },
                ),
              ),
            ),
            _postContainer(
              size: maxSize,
              child: HomeScreenPost(
                homeScreenPostData: HomeScreenPostData(
                  homeScreenPostType: HomeScreenPostType.imageCollection,
                  content: [
                    'https://img.freepik.com/free-photo/view-wild-lion-nature_23-2150460851.jpg',
                    'https://media.cntraveler.com/photos/64c284fe004404ce44203352/16:9/w_1280%2Cc_limit/baros-maldives_aerial-view-july20-pr.jpg',
                    'https://static.toiimg.com/thumb/90651703/90651703.jpg?height=746&width=420&resizemode=76&imgsize=67920',
                    'https://afar.brightspotcdn.com/dims4/default/dd4ced2/2147483647/strip/true/crop/3000x1592+0+323/resize/1440x764!/quality/90/?url=https%3A%2F%2Fk3-prod-afar-media.s3.us-west-2.amazonaws.com%2Fbrightspot%2Fb2%2Ff4%2F9a1ebe3f427f8e5eb937f8df8998%2Ftravelguides-maldives-videomediastudioeurope-shutterstock.jpg',
                    'https://images.tripadeal.com.au/cdn-cgi/image/format=auto,width=800/https://cstad.s3.ap-southeast-2.amazonaws.com/5205_All-Inclusive_Maldives_Fly_and_Stay_WEB_HERO_1.jpg',
                    'https://cdn.pixabay.com/photo/2015/03/09/18/34/beach-666122_1280.jpg',
                  ],
                  postId: '1234DfbdRE85',
                  actionsData: {
                    HomeScreenPostActions.comment: '',
                    HomeScreenPostActions.support: '80 k',
                    HomeScreenPostActions.favorite: '500',
                    HomeScreenPostActions.like: '50 k',
                    HomeScreenPostActions.recommend: '107',
                  },
                ),
              ),
            ),
            _postContainer(
              size: maxSize,
              child: HomeScreenPost(
                homeScreenPostData: HomeScreenPostData(
                  homeScreenPostType: HomeScreenPostType.videoCollection,
                  content: [
                    'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/African%20Lion%20-%20One%20Minute%20Wildlife%20Documentary%20%23shorts.mp4?alt=media&token=4d7cd043-e484-4b46-a14b-48f9f8290e28',
                    'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/videoplayback%20(1).mp4?alt=media&token=9feaf6e2-9cde-4bd1-95ef-0aac4c9942fc',
                    'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/videoplayback%20(2).mp4?alt=media&token=66e3ee54-9a0d-4dd3-b881-776db3f1f759',
                    'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/videoplayback.mp4?alt=media&token=697c11dd-cda8-4caf-bd5f-8d18d18fb646',
                  ],
                  postId: '1234DfbdRE85',
                  actionsData: {
                    HomeScreenPostActions.comment: '10',
                    HomeScreenPostActions.support: '5 k',
                    HomeScreenPostActions.favorite: '750',
                    HomeScreenPostActions.like: '10 k',
                    HomeScreenPostActions.recommend: '3',
                  },
                ),
              ),
            ),
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
