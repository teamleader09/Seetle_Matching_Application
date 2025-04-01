import 'package:flutter/material.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/screen/premium/index.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({super.key});

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 5));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PremiumScreen(),
        ),
      );
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

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop, 
        child: Scaffold(
        backgroundColor: kColorBlack,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/background/success.png',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
