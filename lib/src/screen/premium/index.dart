import 'package:settee/src/common/NotificationPermissionDialog.dart';
import 'package:settee/src/common/termsAgreementDialog.dart';
import 'package:settee/src/constants/app_button.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/screen/onboarding/onboardingScreen.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumScreen extends ConsumerStatefulWidget {
  const PremiumScreen({super.key});
  @override
  ConsumerState<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends ConsumerState<PremiumScreen> {
  bool _termsAgreed = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      await _checkTermsAgreement();
      if (!_termsAgreed) {
        _showTermsDialog();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool allowRevert = true;

  Future<bool> _onWillPop() async {
    if (!allowRevert) {
      return false;
    }
    return false;
  }

  Future<void> _checkTermsAgreement() async {
    final prefs = await SharedPreferences.getInstance();
    _termsAgreed = prefs.getBool('isTermsAgreed') ?? false;
  }

  Future<void> _setTermsAgreed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isTermsAgreed', true);
    setState(() {
      _termsAgreed = true;
    });
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => TermsAgreementDialog(
        content: privacyContent.toString(),
        buttonText: agreeUseIt.toString(),
        onAgree: () async {
          await _setTermsAgreed();
        },
      ),
    );
  }

  void _showNotificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => NotificationPermissionDialog(
        title: question1.toString(),
        content: question2.toString(),
        denyText: dontAllowString,
        allowText: allowString,
        onDeny: () {
          debugPrint('User denied notification permission');
        },
        onAllow: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/background/premium.png',
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: vh(context, 15),
                    child: Image.asset(
                      'assets/images/background/splash_title.png',
                      width: vMin(context, 50),
                      height: vhh(context, 10), 
                    ),
                  ),
                  SizedBox(
                    height: vhh(context, 70),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: vMin(context, 45),
                        child: ButtonWidget(
                          btnType: ButtonWidgetType.notTryItButton,
                          borderColor: kColorBorder,
                          textColor: kColorBlack,
                          fullColor: kColorTransparent,
                          size: false,
                          icon: true,
                          onPressed: () {
                            _showNotificationDialog();
                          },
                        ),
                      ),
                      SizedBox(
                        width: vMin(context, 3),
                      ),
                      SizedBox(
                        width: vMin(context, 45),
                        child: ButtonWidget(
                          btnType: ButtonWidgetType.tryItButton,
                          borderColor: kColorPrimary,
                          textColor: kColorWhite,
                          fullColor: kColorPrimary,
                          size: false,
                          icon: true,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OnboardingScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
