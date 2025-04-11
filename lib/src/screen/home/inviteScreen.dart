import 'package:flutter/material.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/screen/auth/chooseBirthday.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/index.dart';
import 'package:settee/src/common/progressContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreen();
}

class _InviteScreen extends State<InviteScreen> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _handleNext() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', nameController.text);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BirthdayPickerScreen()),
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
    final isButtonEnabled = nameController.text.trim().isNotEmpty;

    return Scaffold(
        backgroundColor: kColorBlack,
        body: WillPopScope(
          onWillPop: _onWillPop,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: vhh(context, 5)),
                  const Text(
                    startWithFriend,
                    style: TextStyle(
                      color: kColorWhite,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: vhh(context, 2)),
                  SizedBox(height: vhh(context, 2)),
                  const Text(
                    inputName,
                    style: TextStyle(
                      color: kColorWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: vhh(context, 2)),
                  SizedBox(
                    height: vhh(context, 6),
                    child: TextField(
                      controller: nameController,
                      style: const TextStyle(color: kColorWhite, fontSize: 14),
                      textAlign: TextAlign.center,
                      keyboardAppearance: Brightness.light,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: inputNamePls,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        border: InputBorder.none,
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(Radius.circular(15)),
                        //   borderSide: BorderSide(color: kColorWhite),
                        // ),
                        // focusedBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.all(Radius.circular(15)),
                        //   borderSide: BorderSide(color: kColorWhite, width: 1),
                        // ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  SizedBox(height: vhh(context, 3)),
                  const Text(
                    nameExample,
                    style: TextStyle(color: kColorLightGray),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
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
                      child: const Text(
                        continueTitle,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: vhh(context, 3)),
                ],
              ),
            ),
          ),
        ));
  }
}
