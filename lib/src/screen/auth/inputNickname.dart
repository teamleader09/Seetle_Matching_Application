import 'package:flutter/material.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/screen/auth/addMember.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/index.dart';

class InputNicknameScreen extends StatefulWidget {
  const InputNicknameScreen({super.key});

  @override
  State<InputNicknameScreen> createState() => _InputNicknameScreenState();
}

class _InputNicknameScreenState extends State<InputNicknameScreen> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  
  void _handleNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddMemberScreen()),
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
                SizedBox(height: vhh(context, 1)),
                const Text(
                  beRealTitle, 
                  style: TextStyle(
                    color: kColorWhite,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: vhh(context, 5)),
                const Text(
                  makeNickname,
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
                      hintText: nickNameExample,
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      border: InputBorder.none,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                
                SizedBox(height: vhh(context, 3)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.remove_circle, color: kColorLightGray, size: 16,),
                    SizedBox(width: vMin(context, 1),),
                    const Text(
                      unUseful,
                      style: TextStyle(color: kColorLightGray),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: vhh(context, 3)),
              ],
            ),
          ),
        ),
      )
    );
  }
}
