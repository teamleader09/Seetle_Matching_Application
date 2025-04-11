import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/screen/auth/inputNickname.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BirthdayPickerScreen extends StatefulWidget {
  const BirthdayPickerScreen({super.key});

  @override
  State<BirthdayPickerScreen> createState() => _BirthdayPickerScreenState();
}

class _BirthdayPickerScreenState extends State<BirthdayPickerScreen> {
  DateTime? selectedDate;

  void _pickDate() async {
    final today = DateTime.now();
    final initialDate = selectedDate ?? DateTime(today.year - 18);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: today,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            dialogBackgroundColor: kColorBlack,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: kColorWhite),
            ),
            colorScheme: const ColorScheme.dark(
              primary: kColorWhite,
              onPrimary: kColorBlack,
              surface: kColorBlack,
              onSurface: kColorWhite,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('yyyy  MM  dd').format(date);
  }

  int _calculateAge(DateTime? birthDate) {
    if (birthDate == null) return 0;
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void _handleNext() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('birthday', selectedDate.toString());

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InputNicknameScreen()),
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
    final age = _calculateAge(selectedDate);

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: kColorBlack,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
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
                    inputBirthday,
                    style: TextStyle(
                      color: kColorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: vhh(context, 2)),
                  GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        selectedDate != null
                            ? _formatDate(selectedDate)
                            : "YYYY  MM  DD",
                        style: const TextStyle(
                          color: kColorWhite,
                          fontSize: 28,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: vhh(context, 2)),
                  const Text(
                    birthdayConfirmed,
                    style: TextStyle(
                      color: kColorLightGray,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selectedDate != null && _calculateAge(selectedDate) >= 16
                        ? () {
                            _handleNext();
                          }
                        : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kColorWhite,
                        disabledBackgroundColor: kColorWhite.withOpacity(0.5),
                        foregroundColor: kColorBlack,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text("私は $age 歳です。"),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }
}
