import 'package:flutter/material.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/controller/authController.dart';
import 'package:settee/src/screen/auth/chooseImage.dart';
import 'package:settee/src/screen/home/map.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/common.dart';
import 'package:settee/src/utils/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
class InputPasswordScreen extends ConsumerStatefulWidget {
  final String type;
  const InputPasswordScreen({super.key, required this.type});

  @override
  ConsumerState<InputPasswordScreen> createState() => _InputPasswordScreenState();
}

class _InputPasswordScreenState extends ConsumerState<InputPasswordScreen> {
  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
  
  void _handleNext() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', passwordController.text);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChooseImageScreen()),
    );
  }

  void _loginHandle() async{
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? phoneNumber = prefs.getString('phone');
    String? emailOrPhone;

    if (email != null && email.isNotEmpty) {
      emailOrPhone = email;
    }
    else if (phoneNumber != null && phoneNumber.isNotEmpty) {
      emailOrPhone = phoneNumber;
    }

    final controller = ref.read(authControllerProvider.notifier);
    controller.loginWithPassword(emailOrPhone??'', passwordController.text).then(
      (value) async{
        if (value == true) {
          Common.showSuccessMessage(successLogin, context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MapScreen()),
          );
        } else {
          Common.showErrorMessage(wrongPassword, context);
        }
      },
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
    final isButtonEnabled = passwordController.text.trim().isNotEmpty && passwordController.text.trim().length >= 8;

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
                        onPressed: isButtonEnabled ? widget.type == 'register' ? _handleNext : _loginHandle : null,
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
