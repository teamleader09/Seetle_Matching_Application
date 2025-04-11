import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/controller/authController.dart';
import 'package:settee/src/screen/auth/congratulation.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/common.dart';
import 'package:settee/src/utils/index.dart';
import 'package:settee/src/common/progressContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

class ChooseImageScreen extends ConsumerStatefulWidget {
  const ChooseImageScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<ChooseImageScreen> createState() => _ChooseImageScreenState();
}

class _ChooseImageScreenState extends ConsumerState<ChooseImageScreen> {
  XFile? _image;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handleNext() async {
    if (_image == null) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('username')!;
    String birthday = prefs.getString('birthday')!;
    String nickName = prefs.getString('nickname')!;
    String password = prefs.getString('password')!;
    String email = prefs.getString('email') ?? '';
    String phone = prefs.getString('phone') ?? '';

    final bytes = await File(_image!.path).readAsBytes();
    String base64Image = base64Encode(bytes);
    String imageName = _image!.path.split('/').last;
    Common.showLoadingDialog(context);
    final controller = ref.read(authControllerProvider.notifier);
    controller
        .registerData(userName, birthday, nickName, password, imageName,
            base64Image, email, phone)
        .then(
      (value) async {
        if (value == true) {
          await prefs.remove('username');
          await prefs.remove('birthday');
          await prefs.remove('nickname');
          await prefs.remove('password');
          await prefs.remove('email');
          await prefs.remove('phone');
          Navigator.of(context).pop();
          Common.showSuccessMessage(registerSuccess, context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CongratulationScreen(),
            ),
          );
        } else {
          Navigator.of(context).pop();
          Common.showSuccessMessage(registerFail, context);
        }
      },
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  bool allowRevert = true;

  Future<bool> _onWillPop() async {
    if (!allowRevert) {
      return false;
    }
    return false;
  }

  Future<void> _takePhoto() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? capturedImage =
        await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = capturedImage;
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: vMin(context, 100),
          height: vhh(context, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: _takePhoto,
                child: const Text(
                  camera,
                  style: TextStyle(
                      color: kColorBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: _pickImage,
                child: const Text(
                  album,
                  style: TextStyle(
                      color: kColorBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  close,
                  style: TextStyle(
                      color: kColorBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
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
                  SizedBox(height: vhh(context, 5)),
                  ProgressContainer(
                    current: 5,
                    total: 6,
                  ),
                  SizedBox(height: vhh(context, 2)),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        chooseProfile,
                        style: TextStyle(
                          color: kColorWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: vhh(context, 4)),
                  GestureDetector(
                    onTap: _showBottomSheet,
                    child: _image == null
                        ? Container(
                            width: vMin(context, 35),
                            height: vMin(context, 35),
                            decoration: BoxDecoration(
                              color: kColorBorder,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: kColorWhite,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(_image!.path),
                              width: vMin(context, 35),
                              height: vMin(context, 35),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  SizedBox(height: vhh(context, 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: vMin(context, 13),
                        child: ElevatedButton(
                          onPressed: _image != null ? _handleNext : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kColorWhite,
                            disabledBackgroundColor:
                                kColorWhite.withOpacity(0.5),
                            foregroundColor: kColorBlack,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Icon(Icons.arrow_right_alt,
                              size: 30, color: kColorBlack),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
