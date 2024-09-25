// Riverpod provider to manage the feed
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/feed_post_data.dart';
import 'package:link_win_mob_app/core/models/feed_post_profile_details.dart';
import 'package:link_win_mob_app/core/models/states/feed_state.dart';
import 'package:link_win_mob_app/core/utils/enums/feed_post_type.dart';

final feedProvider =
    StateNotifierProvider<FeedNotifier, List<FeedState?>>((ref) {
  return FeedNotifier();
});

class FeedNotifier extends StateNotifier<List<FeedState?>> {
  FeedNotifier() : super(_initialFeedData());

  // Method to get mute state for a specific page
  bool isMutedForPage(int pageIndex) {
    final page = state[pageIndex];
    return page?.isMuted ?? true; // Return true if page is null
  }

  // Function to toggle mute/unmute for all videos on a given page
  void toggleMuteForPage(int pageIndex) {
    state = state.map((page) {
      if (page != null && state.indexOf(page) == pageIndex) {
        // Toggle the mute state for the current page
        return page.copyWith(isMuted: !page.isMuted);
      }
      // Return the original page if it's not the one being toggled
      return page;
    }).toList();
  }

  // Method to fetch a post's data using pageIndex and postId
  FeedPostData? fetchPost(int pageIndex, String postId) {
    final page = state[pageIndex];
    if (page != null) {
      try {
        return page.posts.firstWhere((post) => post.postId == postId);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Function to update post data (e.g., loading from firestore)
  void updatePost(int pageIndex, String postId, FeedPostData updatedPost) {
    state = state.map((page) {
      if (page != null && state.indexOf(page) == pageIndex) {
        return page.copyWith(
          posts: page.posts.map((post) {
            if (post.postId == postId) {
              return updatedPost;
            }
            return post;
          }).toList(),
        );
      }
      return page;
    }).toList();
  }

  // to update actions data for a post
  void updatePostAction({
    required int pageIndex,
    required String postId,
    required FeedPostActionData feedPostActionData,
  }) {
    // Create a new state list
    state = state.map((page) {
      if (page != null && state.indexOf(page) == pageIndex) {
        // Create a new instance of the page with updated posts
        return page.copyWith(
          posts: page.posts.map((post) {
            if (post.postId == postId) {
              // Create a new instance of the post with updated actions data
              return post.copyWith(
                actionsData: {
                  ...post.actionsData,
                  feedPostActionData.action: feedPostActionData,
                },
              );
            }
            return post; // Return original post if not updated
          }).toList(),
        );
      }
      return page; // Return the original page if not the one being updated
    }).toList();
  }
}

// Example initial data (replace this with Firestore data)
List<FeedState> _initialFeedData() {
  return [
    FeedState(posts: [
      FeedPostData(
        feedPostType: FeedPostType.image,
        content: [
          'https://img.freepik.com/free-photo/view-wild-lion-nature_23-2150460851.jpg'
        ],
        postId: '1234DfbdRE85',
        actionsData: {
          FeedPostActions.comment: FeedPostActionData(
              action: FeedPostActions.comment, value: 40, isClicked: true),
          FeedPostActions.support: FeedPostActionData(
              action: FeedPostActions.support, value: 69014, isClicked: false),
          FeedPostActions.favorite: FeedPostActionData(
              action: FeedPostActions.favorite, value: 100, isClicked: true),
          FeedPostActions.like: FeedPostActionData(
              action: FeedPostActions.like, value: 100004, isClicked: false),
          FeedPostActions.recommend: FeedPostActionData(
              action: FeedPostActions.recommend, value: 30, isClicked: false),
        },
        feedPostProfileDetails: FeedPostProfileDetails(
          profileName: 'Mohammad Abid',
          profileImgUrl: 'https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg',
        ),
        postedAt: DateTime.parse("2024-08-29 12:34:56"),
        pageIndex: 0,
      ),
      FeedPostData(
        feedPostType: FeedPostType.video,
        content: [
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/African%20Lion%20-%20One%20Minute%20Wildlife%20Documentary%20%23shorts.mp4?alt=media&token=4d7cd043-e484-4b46-a14b-48f9f8290e28'
        ],
        postId: '1534DfMnRE85',
        actionsData: {
          FeedPostActions.comment: FeedPostActionData(
              action: FeedPostActions.comment, value: 50, isClicked: true),
          FeedPostActions.support: FeedPostActionData(
              action: FeedPostActions.support, value: 10412, isClicked: false),
          FeedPostActions.favorite: FeedPostActionData(
              action: FeedPostActions.favorite, value: 50, isClicked: true),
          FeedPostActions.like: FeedPostActionData(
              action: FeedPostActions.like, value: 40101, isClicked: true),
          FeedPostActions.recommend: FeedPostActionData(
              action: FeedPostActions.recommend, value: 0, isClicked: false),
        },
        feedPostProfileDetails: FeedPostProfileDetails(
          profileName: 'Haneen Sabar',
          profileImgUrl:
              'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630',
        ),
        postedAt: DateTime.parse("2024-08-22 12:34:56"),
        pageIndex: 0,
      ),
      FeedPostData(
        feedPostType: FeedPostType.imageCollection,
        content: [
          'https://img.freepik.com/free-photo/view-wild-lion-nature_23-2150460851.jpg',
          'https://media.cntraveler.com/photos/64c284fe004404ce44203352/16:9/w_1280%2Cc_limit/baros-maldives_aerial-view-july20-pr.jpg',
          'https://static.toiimg.com/thumb/90651703/90651703.jpg?height=746&width=420&resizemode=76&imgsize=67920',
          'https://afar.brightspotcdn.com/dims4/default/dd4ced2/2147483647/strip/true/crop/3000x1592+0+323/resize/1440x764!/quality/90/?url=https%3A%2F%2Fk3-prod-afar-media.s3.us-west-2.amazonaws.com%2Fbrightspot%2Fb2%2Ff4%2F9a1ebe3f427f8e5eb937f8df8998%2Ftravelguides-maldives-videomediastudioeurope-shutterstock.jpg',
          'https://images.tripadeal.com.au/cdn-cgi/image/format=auto,width=800/https://cstad.s3.ap-southeast-2.amazonaws.com/5205_All-Inclusive_Maldives_Fly_and_Stay_WEB_HERO_1.jpg',
          'https://cdn.pixabay.com/photo/2015/03/09/18/34/beach-666122_1280.jpg',
        ],
        postId: '7434mnTbdRE5',
        actionsData: {
          FeedPostActions.comment: FeedPostActionData(
              action: FeedPostActions.comment, value: 0, isClicked: false),
          FeedPostActions.support: FeedPostActionData(
              action: FeedPostActions.support,
              value: 80024000,
              isClicked: false),
          FeedPostActions.favorite: FeedPostActionData(
              action: FeedPostActions.favorite, value: 500, isClicked: true),
          FeedPostActions.like: FeedPostActionData(
              action: FeedPostActions.like, value: 50999, isClicked: false),
          FeedPostActions.recommend: FeedPostActionData(
              action: FeedPostActions.recommend, value: 107, isClicked: false),
        },
        feedPostProfileDetails: FeedPostProfileDetails(
          profileName: 'Sam Krosba',
          profileImgUrl:
              'https://img.freepik.com/free-photo/abstract-autumn-beauty-multi-colored-leaf-vein-pattern-generated-by-ai_188544-9871.jpg',
        ),
        postedAt: DateTime.parse("2024-08-27 00:34:56"),
        pageIndex: 0,
      ),
      FeedPostData(
        feedPostType: FeedPostType.videoCollection,
        content: [
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/African%20Lion%20-%20One%20Minute%20Wildlife%20Documentary%20%23shorts.mp4?alt=media&token=4d7cd043-e484-4b46-a14b-48f9f8290e28',
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/videoplayback%20(1).mp4?alt=media&token=9feaf6e2-9cde-4bd1-95ef-0aac4c9942fc',
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/videoplayback%20(2).mp4?alt=media&token=66e3ee54-9a0d-4dd3-b881-776db3f1f759',
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/videoplayback.mp4?alt=media&token=697c11dd-cda8-4caf-bd5f-8d18d18fb646',
        ],
        postId: '18RtnMfbdRE63',
        actionsData: {
          FeedPostActions.comment: FeedPostActionData(
              action: FeedPostActions.comment, value: 10, isClicked: false),
          FeedPostActions.support: FeedPostActionData(
              action: FeedPostActions.support, value: 5020, isClicked: true),
          FeedPostActions.favorite: FeedPostActionData(
              action: FeedPostActions.favorite, value: 750, isClicked: false),
          FeedPostActions.like: FeedPostActionData(
              action: FeedPostActions.like, value: 10001, isClicked: true),
          FeedPostActions.recommend: FeedPostActionData(
              action: FeedPostActions.recommend, value: 3, isClicked: true),
        },
        feedPostProfileDetails: FeedPostProfileDetails(
          profileName: 'Namop Gran',
          profileImgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO8AAxAr9ZNr9JCwn2QZ35rSWWuiayhh0ayQ&s',
        ),
        postedAt: DateTime.parse("2024-08-30 00:38:56"),
        pageIndex: 0,
      ),
    ], isMuted: true),
    FeedState(posts: [
      FeedPostData(
        feedPostType: FeedPostType.image,
        content: [
          'https://img.freepik.com/free-photo/view-wild-lion-nature_23-2150460851.jpg'
        ],
        postId: '8723DDfbdEnM',
        actionsData: {
          FeedPostActions.comment: FeedPostActionData(
              action: FeedPostActions.comment, value: 75, isClicked: false),
          FeedPostActions.support: FeedPostActionData(
              action: FeedPostActions.support, value: 30201, isClicked: false),
          FeedPostActions.favorite: FeedPostActionData(
              action: FeedPostActions.favorite,
              value: 780456,
              isClicked: false),
          FeedPostActions.like: FeedPostActionData(
              action: FeedPostActions.like, value: 170014, isClicked: true),
          FeedPostActions.recommend: FeedPostActionData(
              action: FeedPostActions.recommend, value: 10, isClicked: false),
        },
        feedPostProfileDetails: FeedPostProfileDetails(
          profileName: 'Mohammad Abid',
          profileImgUrl: 'https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg',
        ),
        postedAt: DateTime.parse("2024-08-29 12:34:56"),
        pageIndex: 1,
      ),
      FeedPostData(
        feedPostType: FeedPostType.video,
        content: [
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/African%20Lion%20-%20One%20Minute%20Wildlife%20Documentary%20%23shorts.mp4?alt=media&token=4d7cd043-e484-4b46-a14b-48f9f8290e28'
        ],
        postId: '3846Dfbdnm8S',
        actionsData: {
          FeedPostActions.comment: FeedPostActionData(
              action: FeedPostActions.comment, value: 91, isClicked: false),
          FeedPostActions.support: FeedPostActionData(
              action: FeedPostActions.support, value: 37001, isClicked: true),
          FeedPostActions.favorite: FeedPostActionData(
              action: FeedPostActions.favorite, value: 83558, isClicked: false),
          FeedPostActions.like: FeedPostActionData(
              action: FeedPostActions.like, value: 177000, isClicked: true),
          FeedPostActions.recommend: FeedPostActionData(
              action: FeedPostActions.recommend, value: 0, isClicked: false),
        },
        feedPostProfileDetails: FeedPostProfileDetails(
          profileName: 'Haneen Sabar',
          profileImgUrl:
              'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630',
        ),
        postedAt: DateTime.parse("2024-08-22 12:34:56"),
        pageIndex: 1,
      ),
    ], isMuted: true),
  ];
}
