import 'package:flutter/material.dart';
import 'package:settee/src/common/NotificationPermissionDialog.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/screen/auth/inputPassword.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/index.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _showNotificationDialog();
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
  
  void _handleNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InputPasswordScreen(type: 'register')),
    );
  }

  void _showNotificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => NotificationPermissionDialog(
        title: requestAccess.toString(),
        content: requestAccessSubText.toString(),
        denyText: dontAllowString,
        allowText: allowString,
        onDeny: () {
          debugPrint('User denied notification permission');
        },
        onAllow: () {
          
        },
      ),
    );
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
              children: [
                SizedBox(height: vhh(context, 1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: vMin(context, 35)),
                      child: const Text(
                        beRealTitle, 
                        style: TextStyle(
                          color: kColorWhite,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: vMin(context, 20)),
                      child: InkWell(
                        onTap: () {
                          _handleNext();
                        },
                        child: const Text(skipText, style: TextStyle(color: kColorLightGray),),
                      )
                    )
                  ],
                ),
                
                SizedBox(height: vhh(context, 5)),
                const Text(
                  findFriend,
                  style: TextStyle(
                    color: kColorWhite,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: vhh(context, 2)),

                const Text(
                  findFriendSubText,
                  style: TextStyle(
                    color: kColorLightGray,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                
              ],
            ),
          ),
        ),
      )
    );
  }
}
