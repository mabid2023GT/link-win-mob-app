import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/on_boarding/on_boarding_screen_background.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/responsive_percentage_layout.dart';
import 'dart:math' as math;

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _pageIndex = 0;

  _onPageChanged(int index) {
    setState(() => _pageIndex = index);
  }

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Welcome to',
      'subtitle': 'LinkWin',
      'image': 'assets/images/OnBoardingBGImgPageView01.png',
      'description': 'Job Matching Platform',
    },
    {
      'title': 'Welcome to',
      'subtitle': 'LinkWin',
      'image': 'assets/images/OnBoardingBGImgPageView02.png',
      'description': 'Service Connection Hub',
    },
    {
      'title': 'Welcome to',
      'subtitle': 'LinkWin',
      'image': 'assets/images/OnBoardingBGImgPageView03.png',
      'description': 'Time and Cost-Saving',
    },
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil(context);

    return OnBoardingScreenBackground(
      child: Scaffold(
        backgroundColor: transparent,
        body: ResponsivePercentageLayout(
          size: Size(screenUtil.screenWidth, screenUtil.screenHeight),
          screenUtil: screenUtil,
          isRow: false,
          percentages: const [15, 50, 10, 25],
          children: [
            const SizedBox(),
            _pageBuilder(screenUtil),
            PageIndicator(
                screenUtil: screenUtil,
                pageIndex: _pageIndex,
                pageCount: _onboardingData.length),
            NextButton(
              onTap: () {
                context.go('/nav');
              },
            ),
          ],
        ),
      ),
    );
  }

  _pageBuilder(ScreenUtil screenUtil) {
    return PageView.builder(
      itemCount: _onboardingData.length,
      itemBuilder: (context, index) =>
          OnBoardingPage(data: _onboardingData[index], screenUtil: screenUtil),
      onPageChanged: _onPageChanged,
    );
  }
}

// OnBoardingPage Widget
class OnBoardingPage extends StatelessWidget {
  final Map<String, String> data;
  final ScreenUtil screenUtil;

  const OnBoardingPage({required this.data, required this.screenUtil, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoResponsivePercentageLayout(
      screenUtil: screenUtil,
      isRow: false,
      percentages: const [
        5,
        15,
        60,
        20,
      ],
      children: [
        _welcomToWidget(context),
        _linkWinWidget(context),
        _imageWidget(context),
        _descriptionWidget(context),
      ],
    );

    // return LayoutBuilderChild(
    //   child: (minSize, maxSize) => Container(
    //     color: Colors.transparent,
    //     width: maxSize.width,
    //     height: maxSize.height,
    //     child: ResponsivePercentageLayout(
    //       size: maxSize,
    //       screenUtil: screenUtil,
    //       isRow: false,
    //       percentages: const [
    //         5,
    //         15,
    //         60,
    //         20,
    //       ],
    //       children: [
    //         _welcomToWidget(context),
    //         _linkWinWidget(context),
    //         _imageWidget(context),
    //         _descriptionWidget(context),
    //       ],
    //     ),
    //   ),
    // );
  }

  _welcomToWidget(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => Container(
        width: maxSize.width,
        height: maxSize.height,
        alignment: Alignment.center,
        child: Text(
          data['title'] ?? 'Welcome to',
          style: Theme.of(context).textTheme.bodyLarge!.apply(
                fontSizeFactor: MediaQuery.of(context).textScaler.scale(
                      0.8,
                    ),
              ),
        ),
      ),
    );
  }

  _linkWinWidget(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => Container(
        width: maxSize.width,
        height: maxSize.height,
        alignment: Alignment.center,
        child: Text(
          data['subtitle'] ?? 'LinkWin',
          style: Theme.of(context).textTheme.displayLarge!.apply(
                fontSizeFactor: MediaQuery.of(context).textScaler.scale(
                      0.8,
                    ),
              ),
        ),
      ),
    );
  }

  _imageWidget(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        return SizedBox(
          width: maxSize.width,
          height: maxSize.height,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Image.asset(
              data['image'] ?? 'assets/images/OnBoardingBGImgPageView01.png',
            ),
          ),
        );
      },
    );
  }

  _descriptionWidget(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => Container(
        width: maxSize.width,
        height: maxSize.height,
        alignment: Alignment.center,
        child: Text(
          data['description'] ?? 'Job Matching Platform',
          style: Theme.of(context).textTheme.displaySmall!.apply(
                fontSizeFactor: MediaQuery.of(context).textScaler.scale(
                      0.8,
                    ),
              ),
        ),
      ),
    );
  }
}

// PageIndicator Widget
class PageIndicator extends StatelessWidget {
  final int pageIndex;
  final int pageCount;
  final ScreenUtil screenUtil;

  const PageIndicator(
      {required this.pageIndex,
      required this.pageCount,
      Key? key,
      required this.screenUtil})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pageCount,
          (index) => Container(
            height: maxSize.width *
                screenUtil.adjustPercentageForScreenWidth(
                  maxSize.width,
                  0.05,
                ),
            width: maxSize.width *
                screenUtil.adjustPercentageForScreenWidth(
                  maxSize.width,
                  0.05,
                ),
            margin: EdgeInsets.symmetric(
              horizontal: maxSize.width *
                  screenUtil.adjustPercentageForScreenWidth(
                    maxSize.width,
                    0.01,
                  ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: pageIndex == index ? kBlack : null,
              border: Border.all(
                  width: maxSize.width *
                      screenUtil.adjustPercentageForScreenWidth(
                        maxSize.width,
                        0.003,
                      ),
                  color: kBlack),
            ),
          ),
        ),
      ),
    );
  }
}

// NextButton Widget
class NextButton extends StatelessWidget {
  final VoidCallback onTap;
  const NextButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) => Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Transform.rotate(
              angle: math.pi / 5,
              child: InkWell(
                onTap: onTap,
                splashColor: k2MainThemeColor,
                child: Container(
                  height: maxSize.height * 0.69,
                  width: maxSize.height * 0.58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: maxSize.height * 0.01, color: kBlack),
                    borderRadius: BorderRadius.circular(maxSize.height * 0.2),
                  ),
                  child: Container(
                    height: maxSize.height * 0.59,
                    width: maxSize.height * 0.48,
                    decoration: BoxDecoration(
                      color: kBlack,
                      borderRadius: BorderRadius.circular(maxSize.height * 0.1),
                    ),
                    child: Transform.rotate(
                      angle: -math.pi / 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: maxSize.height * 0.03),
                          Text(
                            'Next',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: kWhite,
                                  fontWeight: FontWeight.w500,
                                )
                                .apply(
                                  fontSizeFactor:
                                      MediaQuery.of(context).textScaler.scale(
                                            0.9,
                                          ),
                                ),
                          ),
                          SizedBox(width: maxSize.height * 0.03),
                          SvgPicture.asset(
                            'assets/icons/arrow_forward.svg',
                            colorFilter:
                                const ColorFilter.mode(white, BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
