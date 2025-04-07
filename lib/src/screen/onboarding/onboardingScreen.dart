import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seetle/src/constants/app_button.dart';
import 'package:seetle/src/constants/app_styles.dart';
import 'package:seetle/src/screen/auth/phoneLogin.dart';
import 'package:seetle/src/translate/jp.dart';
import 'package:seetle/src/utils/index.dart';

class OnboardingItem {
  final String imagePath;
  final String title;
  final String subtitle;

  OnboardingItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});
  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      imagePath: 'assets/images/background/onboarding_1.png',
      title: onboardingHeaderTitle1,
      subtitle: onboardingSubTitle1,
    ),
    OnboardingItem(
      imagePath: 'assets/images/background/onboarding_2.png',
      title: onboardingHeaderTitle2,
      subtitle: onboardingSubTitle2,
    ),
    OnboardingItem(
      imagePath: 'assets/images/background/onboarding_3.png',
      title: onboardingHeaderTitle3,
      subtitle: onboardingSubTitle3,
    ),
    OnboardingItem(
      imagePath: 'assets/images/background/onboarding_4.png',
      title: onboardingHeaderTitle4,
      subtitle: onboardingSubTitle4,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const PhoneLoginScreen()),
      );
    }
  }

  bool allowRevert = true;

  Future<bool> _onWillPop() async {
    if (!allowRevert) {
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
        child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _onboardingItems.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  _onboardingItems[index].imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _onboardingItems[_currentPage].title,
                      style: const TextStyle(
                        color: kColorWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: vhh(context, 1)),
                    Text(
                      _onboardingItems[_currentPage].subtitle,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: vhh(context, 3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingItems.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.white54,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: vhh(context, 3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: vMin(context, 45),
                          child: ButtonWidget(
                            btnType: ButtonWidgetType.nowStart,
                            borderColor: kColorTransparent,
                            textColor: kColorWhite,
                            fullColor: kColorTransparent,
                            size: false,
                            icon: true,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PhoneLoginScreen()),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: vMin(context, 3),),
                        SizedBox(
                          width: vMin(context, 45),
                          child: ButtonWidget(
                            btnType: ButtonWidgetType.nextString,
                            borderColor: kColorBlack,
                            textColor: kColorWhite,
                            fullColor: kColorBlack,
                            size: false,
                            icon: true,
                            onPressed: _nextPage,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
