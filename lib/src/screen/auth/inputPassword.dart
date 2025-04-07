import 'package:flutter/material.dart';
import 'package:seetle/src/constants/app_styles.dart';
import 'package:seetle/src/screen/auth/chooseImage.dart';
import 'package:seetle/src/translate/jp.dart';
import 'package:seetle/src/utils/index.dart';

class InputPasswordScreen extends StatefulWidget {
  const InputPasswordScreen({super.key});

  @override
  State<InputPasswordScreen> createState() => _InputPasswordScreenState();
}

class _InputPasswordScreenState extends State<InputPasswordScreen> {
  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
  
  void _handleNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChooseImageScreen()),
    );
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
    final isButtonEnabled = passwordController.text.trim().isNotEmpty;

    return WillPopScope(
      onWillPop: _onWillPop,
        child: Scaffold(
        backgroundColor: kColorBlack,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: vhh(context, 10)),
                const Text(
                  requestPassword,
                  style: TextStyle(
                    color: kColorWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: vhh(context, 4)),
                SizedBox(
                  height: vhh(context, 6),
                  child: TextField(
                    controller: passwordController,
                    style: const TextStyle(color: kColorWhite, fontSize: 14),
                    textAlign: TextAlign.center,
                    keyboardAppearance: Brightness.light,
                    decoration: const InputDecoration(
                      hintText: inputPassword,
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      border: InputBorder.none,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                
                SizedBox(height: vhh(context, 10)),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: vMin(context, 13),
                      child: ElevatedButton(
                        onPressed: isButtonEnabled ? _handleNext : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kColorWhite,
                          disabledBackgroundColor: kColorWhite.withOpacity(0.5),
                          foregroundColor: kColorBlack,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Icon(Icons.arrow_right_alt, size: 30, color: kColorBlack,)
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
