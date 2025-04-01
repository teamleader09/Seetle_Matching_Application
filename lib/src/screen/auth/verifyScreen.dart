import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:settee/src/common/authHeader.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/screen/auth/nameScreen.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/index.dart';

class Verifyscreen extends StatefulWidget {
  final String? dialCode;
  final String? phoneNumber;
  final String? email;
  const Verifyscreen({
    super.key, 
    this.dialCode,
    this.phoneNumber,
    this.email,});

  @override
  State<Verifyscreen> createState() => _VerifyscreenState();
}

class _VerifyscreenState extends State<Verifyscreen> {
  final verifyCodeController = TextEditingController();

  @override
  void dispose() {
    verifyCodeController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NameInputScreen(
        )),
    );
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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
                onPressed: isButtonEnabled ? _onNextPressed : null,
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
                child: const Text(nextString, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorWhite,
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}