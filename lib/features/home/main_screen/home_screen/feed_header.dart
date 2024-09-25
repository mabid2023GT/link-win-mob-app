import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/feed_sponsored_ads_data.dart';
import 'package:link_win_mob_app/providers/home/feed_sponsored_ads_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class FeedHeader extends ConsumerStatefulWidget {
  const FeedHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedHeaderState();
}

class _FeedHeaderState extends ConsumerState<FeedHeader> {
  late final ScrollController _scrollController;
  Timer? _autoScrollTimer;
  double _adWidth = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    // Delay between each scroll
    const duration = Duration(seconds: 3);
    _autoScrollTimer = Timer.periodic(
      duration,
      (timer) {
        // Get the current scroll position and maximum scroll extent
        final currentPosition = _scrollController.position.pixels;
        final maxScrollExtent = _scrollController.position.maxScrollExtent;

        // Check if there are more items to scroll
        if (currentPosition >= maxScrollExtent) {
          // Scroll to the beginning for infinite looping
          _scrollController.jumpTo(0);
        } else {
          // Auto-Scroll by a certain amount
          _scrollController.animateTo(
            currentPosition + _adWidth,
            // Animation Speed
            duration: const Duration(
              milliseconds: 500,
            ),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sponsoredAds = ref.watch(feedSponsoredAdsProvider);

    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        double headerLeftRightPadding = maxSize.width * 0.02;
        double leftRightPadding = maxSize.width * 0.0;
        double topBottomPadding = maxSize.height * 0.0;
        Size childSize = Size(maxSize.width - 2 * leftRightPadding,
            maxSize.height - 2 * topBottomPadding);
        Size sponsoredTitleSize =
            Size(childSize.width, childSize.height * 0.15);
        Size listSize =
            Size(childSize.width, childSize.height - sponsoredTitleSize.height);
        return Container(
          width: maxSize.width,
          height: maxSize.height,
          padding: EdgeInsets.only(
            left: leftRightPadding,
            right: leftRightPadding,
            top: topBottomPadding,
            bottom: topBottomPadding,
          ),
          decoration: BoxDecoration(
              color: kHeaderColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(childSize.height * 0.1),
                bottomRight: Radius.circular(childSize.height * 0.1),
              )),
          child: _body(
            headerLeftRightPadding,
            childSize,
            sponsoredTitleSize,
            listSize,
            sponsoredAds,
          ),
        );
      },
    );
  }

  Widget _body(
    double headerLeftRightPadding,
    Size childSize,
    Size sponsoredTitleSize,
    Size listSize,
    List<FeedSponsoredAdsData> sponsoredAds,
  ) {
    return SizedBox(
      width: childSize.width,
      height: childSize.height,
      child: Column(
        children: [
          SizedBox(
            width: sponsoredTitleSize.width,
            height: sponsoredTitleSize.height,
            child: const SponsoredTitleWidget(),
          ),
          SizedBox(
            width: listSize.width,
            height: listSize.height,
            child: _buildSponsoredList(sponsoredAds),
          ),
        ],
      ),
    );
  }

  Widget _buildSponsoredList(List<FeedSponsoredAdsData> sponsoredAds) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        double topBottomPadding = maxSize.height * 0.03;
        Size adSize =
            Size(maxSize.width * 0.7, maxSize.height - 2 * topBottomPadding);
        _adWidth = adSize.width;
        return Padding(
          padding: EdgeInsets.only(
            top: topBottomPadding,
            bottom: topBottomPadding,
            left: maxSize.width * 0.025,
            right: maxSize.width * 0.025,
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: sponsoredAds.length,
            itemBuilder: (context, index) {
              // Using provider to fetch the sponsored ads
              final ad = sponsoredAds[index];
              return _buildSponsoredAd(adSize, ad.imageUrl);
            },
            separatorBuilder: (context, index) => SizedBox(
              width: maxSize.width * 0.025,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSponsoredAd(Size adSize, String url) {
    return Container(
      width: adSize.width,
      height: adSize.height,
      decoration: BoxDecoration(
        color: kHeaderColor,
        borderRadius: BorderRadius.circular(adSize.height * 0.1),
        border: Border.all(
          color: kBlack,
          width: 1.0,
        ),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class SponsoredTitleWidget extends StatelessWidget {
  const SponsoredTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String sponsoredLabel = "Sponsored";

    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size childSize = Size(maxSize.width * 0.2, maxSize.height);
        return Container(
          width: maxSize.width,
          height: maxSize.height,
          alignment: AlignmentDirectional.centerStart,
          padding: EdgeInsets.symmetric(
            horizontal: maxSize.width * 0.025,
          ),
          child: _child(childSize, maxSize, sponsoredLabel),
        );
      },
    );
  }

  Widget _child(Size childSize, Size maxSize, String sponsoredLabel) {
    return Container(
      width: childSize.width,
      height: childSize.height,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: kHeaderColor,
        borderRadius: BorderRadius.circular(maxSize.height * 0.5),
        border: Border.all(
          color: kBlack,
          width: 1.0,
        ),
      ),
      child: Text(
        sponsoredLabel,
        style: const TextStyle(
            color: kBlack, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }
}
