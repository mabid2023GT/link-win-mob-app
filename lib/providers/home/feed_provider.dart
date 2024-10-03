// Riverpod provider to manage the feed
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_data.dart';
import 'package:link_win_mob_app/core/models/feed/feed_post_profile_details.dart';
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
          'https://img.freepik.com/premium-photo/property-construction-beautiful-landscape-home-design-forest-residential-modern-architecture-wood-villa-dwelling-wooden-housing-grass-night-outdoor-building-exterior-summer-sky_163305-242316.jpg'
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
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/2%20MINUTE%20FRONT%20YARD%20URBAN%20GARDEN%20TOUR_%20Homestead%20Dreaming.mp4?alt=media&token=d926666c-d15d-419c-9a56-bb2ec8580d57',
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
          'https://previews.123rf.com/images/tieury/tieury1201/tieury120100009/11853532-a-carpenter-working-in-his-house.jpg',
          'https://cdnassets.hw.net/dims4/GG/838b124/2147483647/resize/300x%3E/quality/90/?url=https%3A%2F%2Fcdnassets.hw.net%2Fde%2F31%2F7193a5de4d5e93ec14407570a36f%2Fhome-builder-marking-wood-adobestock-88564788.jpg',
          'https://www.shutterstock.com/shutterstock/videos/1094003367/thumb/1.jpg?ip=x480',
          'https://media.istockphoto.com/id/1164461192/photo/carpenter-making-a-piece-of-furniture-using-a-router.jpg?s=612x612&w=0&k=20&c=SIHb3f8wRmn1AwaHLx5zL2N2w5UbS9f0Td_6tZSVL8w=',
          'https://www.shutterstock.com/shutterstock/videos/1089170041/thumb/1.jpg?ip=x480',
          'https://www.shutterstock.com/shutterstock/videos/1103325035/thumb/12.jpg?ip=x480',
          'https://i.ebayimg.com/images/g/4Q0AAOSw1yBk3DPD/s-l400.jpg',
          // --------------------
          'https://previews.123rf.com/images/tieury/tieury1201/tieury120100009/11853532-a-carpenter-working-in-his-house.jpg',
          'https://cdnassets.hw.net/dims4/GG/838b124/2147483647/resize/300x%3E/quality/90/?url=https%3A%2F%2Fcdnassets.hw.net%2Fde%2F31%2F7193a5de4d5e93ec14407570a36f%2Fhome-builder-marking-wood-adobestock-88564788.jpg',
          'https://www.shutterstock.com/shutterstock/videos/1094003367/thumb/1.jpg?ip=x480',
          'https://media.istockphoto.com/id/1164461192/photo/carpenter-making-a-piece-of-furniture-using-a-router.jpg?s=612x612&w=0&k=20&c=SIHb3f8wRmn1AwaHLx5zL2N2w5UbS9f0Td_6tZSVL8w=',
          'https://www.shutterstock.com/shutterstock/videos/1089170041/thumb/1.jpg?ip=x480',
          'https://www.shutterstock.com/shutterstock/videos/1103325035/thumb/12.jpg?ip=x480',
          'https://i.ebayimg.com/images/g/4Q0AAOSw1yBk3DPD/s-l400.jpg',
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
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/Cinematic%20Real%20estate%20video%20tour%20example%204K%20_%20Laowa%2012mm%20%26%20Sony%20A7III.mp4?alt=media&token=0ace7452-e746-43ee-b9b7-bb89d73cfb65',
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/Crown%20Towers%20build%20up%203D%20animation.mp4?alt=media&token=0468fd11-1004-49cf-91cb-002ecf4f0db0',
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/DESIGNER%20RESIDENCE%20_%20CINEMATIC%20REAL%20ESTATE%20VIDEO%20IN%204K%20_%20SONY%20FX6.mp4?alt=media&token=2ab56343-c127-4463-88d9-902aebd69b1d',
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/Living%20Room%20Interior%20Design.mp4?alt=media&token=4457015b-8697-4201-bc21-27e57dab9a9f',
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/The%20WORLD%20S%20SMOOTHEST%20cinematic%20PROPERTY%20VIDEO%20_%20SONY%20FX6.mp4?alt=media&token=fc9c77be-bd2c-4173-bad6-cb90bbd3343d',
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
        feedPostType: FeedPostType.imageCollection,
        content: [
          'https://thinkwood-wordpress.s3.amazonaws.com/wp-content/uploads/2023/05/08142334/Think-Wood-Mass-Timber-Tools-Header-%E2%80%93-1-1024x678.png',
          'https://www.shutterstock.com/shutterstock/videos/1089170041/thumb/1.jpg?ip=x480',
          'https://static.vecteezy.com/system/resources/previews/022/886/379/non_2x/modern-wood-and-concrete-kitchen-interior-with-empty-mock-up-place-on-wall-island-appliances-and-window-with-city-view-and-daylight-ai-generated-photo.jpeg',
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
          'https://firebasestorage.googleapis.com/v0/b/link-win-daf7d.appspot.com/o/Construction%20Commercial%20Cinematic%20Video.mp4?alt=media&token=196f30b1-a337-40d1-aeb1-de295c62a3bf',
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
