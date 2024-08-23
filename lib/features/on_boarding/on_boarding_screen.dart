import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/on_boarding/on_boarding_screen_background.dart';
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
        body: Column(
          children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 6,
              child: PageView.builder(
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) => OnBoardingPage(
                    data: _onboardingData[index], screenUtil: screenUtil),
                onPageChanged: _onPageChanged,
              ),
            ),
            Expanded(
              flex: 1,
              child: PageIndicator(
                  pageIndex: _pageIndex, pageCount: _onboardingData.length),
            ),
            Expanded(
              flex: 2,
              child: NextButton(screenUtil: screenUtil),
            ),
          ],
        ),
      ),
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isLandscape
              ? screenUtil.screenWidth * 0.1
              : screenUtil.screenWidth * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data['title'] ?? 'Welcome to',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: screenUtil.screenHeight * 0.02),
          Text(
            data['subtitle'] ?? 'LinkWin',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(height: screenUtil.screenHeight * 0.03),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(2.0),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Image.asset(
                  data['image'] ??
                      'assets/images/OnBoardingBGImgPageView01.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(height: screenUtil.screenHeight * 0.02),
          Text(
            data['description'] ?? 'Job Matching Platform',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}

// PageIndicator Widget
class PageIndicator extends StatelessWidget {
  final int pageIndex;
  final int pageCount;

  const PageIndicator(
      {required this.pageIndex, required this.pageCount, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          height: 12.0,
          width: 12.0,
          margin: const EdgeInsets.symmetric(horizontal: 3.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: pageIndex == index ? kBlack : null,
            border: Border.all(width: 1.0, color: kBlack),
          ),
        ),
      ),
    );
  }
}

// NextButton Widget
class NextButton extends StatelessWidget {
  final ScreenUtil screenUtil;

  const NextButton({required this.screenUtil, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Positioned(
            bottom: -10,
            right: -40,
            child: Transform.rotate(
              angle: math.pi / 5,
              child: Container(
                height: screenUtil.screenWidth * 0.39,
                width: screenUtil.screenWidth * 0.48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: kBlack),
                  borderRadius: BorderRadius.circular(49.0),
                ),
                child: Container(
                  height: screenUtil.screenWidth * 0.35,
                  width: screenUtil.screenWidth * 0.42,
                  decoration: BoxDecoration(
                    color: kBlack,
                    borderRadius: BorderRadius.circular(49.0),
                  ),
                  child: Transform.rotate(
                    angle: -math.pi / 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 16.0),
                        Text(
                          'Next',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: kWhite),
                        ),
                        const SizedBox(width: 16.0),
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
        ],
      ),
    );
  }
}
