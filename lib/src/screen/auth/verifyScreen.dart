import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:settee/src/common/authHeader.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/controller/authController.dart';
import 'package:settee/src/model/sendOTP.dart';
import 'package:settee/src/screen/auth/inputPassword.dart';
import 'package:settee/src/screen/auth/nameScreen.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/common.dart';
import 'package:settee/src/utils/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

class Verifyscreen extends ConsumerStatefulWidget {
  final String? dialCode;
  final String? phoneNumber;
  final String? email;
  final String? verifyReceivedCode;
  final String? uid;
  final String? type;
  const Verifyscreen(
      {super.key,
      this.dialCode,
      this.phoneNumber,
      this.email,
      this.verifyReceivedCode,
      this.uid,
      this.type});

  @override
  ConsumerState<Verifyscreen> createState() => _VerifyscreenState();
}

class _VerifyscreenState extends ConsumerState<Verifyscreen> {
  final verifyCodeController = TextEditingController();
  final SendOTPController sendOTP = SendOTPController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {
    verifyCodeController.dispose();
    super.dispose();
  }

  void verifyCode() async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verifyReceivedCode!,
        smsCode: verifyCodeController.text,
      );

      await auth.signInWithCredential(credential).then((value) async {
        Common.showSuccessMessage(verifiedOTP, context);
        final controller = ref.read(authControllerProvider.notifier);
          controller.loginAction('${widget.dialCode}${widget.phoneNumber}').then(
          (value) async{
            if (value == true) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('phone', '${widget.dialCode}${widget.phoneNumber}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InputPasswordScreen(type: 'login'),
                ),
              );
            } else {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('phone', '${widget.dialCode}${widget.phoneNumber}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NameInputScreen(),
                ),
              );
            }
          },
        );
      });
    } on FirebaseAuthException catch (e) {
      Common.showErrorMessage(verifiedError, context);
    }
  }

  void verifyEmailCode() async {
    Common.showLoadingDialog(context);
    if (await EmailOTP.verifyOTP(otp: verifyCodeController.text)) {
      Navigator.of(context).pop();
      final controller = ref.read(authControllerProvider.notifier);
        controller.loginAction(widget.email!).then(
        (value) async{
          if (value == true) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('email', widget.email!);
            Common.showSuccessMessage(verifiedOTP, context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InputPasswordScreen(type: 'login'),
            ));
          } else {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('email', widget.email!);
            Common.showSuccessMessage(verifiedOTP, context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NameInputScreen(),
            ));
          }
        },
      );
    } else {
      Navigator.of(context).pop();
      Common.showErrorMessage(verifiedError, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = verifyCodeController.text.length == 6;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: vhh(context, 5)),
            const AuthHeaderWidget(),
            Center(
              child: Text(
                checkedCode.toString(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: vhh(context, 3)),
            Center(
              child: Text(
                widget.email != null
                    ? '認証コードを ${widget.email} に送信しました'
                    : 'SMSを ${widget.dialCode}${widget.phoneNumber} ${sendMsg.toString()}',
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: vhh(context, 3)),
            Container(
              height: vhh(context, 6),
              decoration: BoxDecoration(
                color: kColorLightGray,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    controller: verifyCodeController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      isCollapsed: true,
                      fillColor: kColorLightGray,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: vhh(context, 2)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? widget.type == "loginOfPhone"
                        ? verifyCode
                        : verifyEmailCode
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kColorMediumBlue,
                  foregroundColor: kColorWhite,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  disabledBackgroundColor:
                      // ignore: deprecated_member_use
                      kColorMediumBlue.withOpacity(0.5),
                ),
                child: const Text(
                  nextString,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kColorWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
