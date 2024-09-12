import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_data.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_profile_details.dart';
import 'package:link_win_mob_app/core/models/home_screen_post_state.dart';
import 'package:link_win_mob_app/core/utils/enums/home_screen_post_type.dart';
import 'package:link_win_mob_app/providers/home/post_feed_controller.dart';

final postFeedProvider =
    StateNotifierProvider<PostFeedController, List<HomeScreenPostState>>((ref) {
  final posts = ref.watch(_postsProvider);
  return PostFeedController(posts);
});

final _postsProvider = Provider<List<HomeScreenPostData>>((ref) {
  return [
    HomeScreenPostData(
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
      homeScreenPostProfileDetails: HomeScreenPostProfileDetails(
        profileName: 'Mohammad Abid',
        profileImgUrl: 'https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg',
      ),
      postedAt: DateTime.parse("2024-08-29 12:34:56"),
    ),
    HomeScreenPostData(
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
      homeScreenPostProfileDetails: HomeScreenPostProfileDetails(
        profileName: 'Haneen Sabar',
        profileImgUrl:
            'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630',
      ),
      postedAt: DateTime.parse("2024-08-22 12:34:56"),
    ),
    HomeScreenPostData(
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
      homeScreenPostProfileDetails: HomeScreenPostProfileDetails(
        profileName: 'Sam Krosba',
        profileImgUrl:
            'https://img.freepik.com/free-photo/abstract-autumn-beauty-multi-colored-leaf-vein-pattern-generated-by-ai_188544-9871.jpg',
      ),
      postedAt: DateTime.parse("2024-08-27 00:34:56"),
    ),
    HomeScreenPostData(
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
      homeScreenPostProfileDetails: HomeScreenPostProfileDetails(
        profileName: 'Namop Gran',
        profileImgUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO8AAxAr9ZNr9JCwn2QZ35rSWWuiayhh0ayQ&s',
      ),
      postedAt: DateTime.parse("2024-08-30 00:38:56"),
    ),
  ];
});
