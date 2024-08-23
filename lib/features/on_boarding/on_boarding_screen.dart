import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/features/on_boarding/on_boarding_screen_background.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _pageIndex = 0;

  _onPageChanged(index) {
    setState(() => _pageIndex = index);
  }

  // List of onboarding data
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
    return OnBoardingScreenBackground(
      child: Scaffold(
        backgroundColor: transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 9,
              child: PageView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  final item = _onboardingData[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item['title'] ?? 'Welcome to',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        item['subtitle'] ?? 'LinkWin',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Container(
                        padding: const EdgeInsets.all(
                          2.0,
                        ),
                        child: Image.asset(
                          item['image'] ??
                              'assets/images/OnBoardingBGImgPageView01.png',
                        ),
                      ),
                      Text(
                        item['description'] ?? 'Job Matching Platform',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  );
                },
                onPageChanged: _onPageChanged,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  height: 12.0,
                  width: 12.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3.5,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _pageIndex == index ? kBlack : null,
                    border: Border.all(
                      width: 1.0,
                      color: kBlack,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(flex: 1, child: Container())
          ],
        ),
      ),
    );
  }
}
