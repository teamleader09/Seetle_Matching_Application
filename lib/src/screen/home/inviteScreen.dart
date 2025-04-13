import 'package:flutter/material.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/screen/auth/chooseBirthday.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/index.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:settee/src/utils/generateQRCode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreen();
}

class _InviteScreen extends State<InviteScreen> {
  final nameController = TextEditingController();
  String _qrData = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await DeviceQRGenerator.generateDeviceData();
    setState(() {
      _qrData = data;
    });
  }

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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.purple,
                              Colors.blue,
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: vhh(context, 15)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/background/logo.png',
                                    width: 50, height: 50),
                                SizedBox(width: vhh(context, 1)),
                                Image.asset(
                                    'assets/images/background/splash_title.png',
                                    width: 172,
                                    height: 40),
                              ],
                            ),
                            SizedBox(height: vhh(context, 2)),
                            QrImageView(
                              data: _qrData,
                              size: 150,
                              backgroundColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: vhh(context, 2)),
                  const Text(
                    sendToFriend,
                    style: TextStyle(
                      color: kColorWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
