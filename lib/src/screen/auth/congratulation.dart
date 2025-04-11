import 'package:flutter/material.dart';
import 'package:settee/src/utils/index.dart';
import 'package:settee/src/common/progressContainer.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/screen/home/map.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({super.key});

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(),
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/success.png'),
              fit: BoxFit.contain, // or BoxFit.contain
              alignment: Alignment.center,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: vhh(context, 10)),
                ProgressContainer(current: 6, total: 6),
                SizedBox(height: vhh(context, 2)),
                // Rest of your content...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
