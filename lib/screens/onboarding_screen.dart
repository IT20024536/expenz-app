import 'package:expenz/data/onboarding_data.dart';
import 'package:expenz/screens/onboarding/front_page.dart';
import 'package:expenz/screens/onboarding/shared_onboarding_screen.dart';
import 'package:expenz/screens/user_data_screen.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool showDetailsPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kDefalutPadding),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() {
                        showDetailsPage = index == 3;
                      });
                    },
                    children: [
                      FrontPage(),
                      SharedOnboardingScreen(
                        title: OnboardingData.onboardingDataList[0].title,
                        imagePath:
                            OnboardingData.onboardingDataList[0].imagePath,
                        description:
                            OnboardingData.onboardingDataList[0].description,
                      ),
                      SharedOnboardingScreen(
                        title: OnboardingData.onboardingDataList[1].title,
                        imagePath:
                            OnboardingData.onboardingDataList[1].imagePath,
                        description:
                            OnboardingData.onboardingDataList[1].description,
                      ),
                      SharedOnboardingScreen(
                        title: OnboardingData.onboardingDataList[2].title,
                        imagePath:
                            OnboardingData.onboardingDataList[2].imagePath,
                        description:
                            OnboardingData.onboardingDataList[2].description,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment(0, 0.75),
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 4,
                      effect: WormEffect(
                        dotColor: kLightGrey,
                        activeDotColor: kMainColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 0,
                    left: 0,
                    child:
                        !showDetailsPage
                            ? GestureDetector(
                              onTap: () {
                                _controller.animateToPage(
                                  _controller.page!.toInt() + 1,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: CustomButton(
                                buttonName:
                                    showDetailsPage ? "Get Started" : "Next",
                                buttonColor: kMainColor,
                              ),
                            )
                            : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserDataScreen(),
                                  ),
                                );
                              },
                              child: CustomButton(
                                buttonName:
                                    showDetailsPage ? "Get Started" : "Next",
                                buttonColor: kMainColor,
                              ),
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
