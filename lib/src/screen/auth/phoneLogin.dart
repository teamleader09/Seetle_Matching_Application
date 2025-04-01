import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:settee/src/common/authHeader.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/screen/auth/verifyScreen.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/index.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  bool isPhoneSelected = true;
  String dialCode = '+81';

  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool get isPhoneValid => phoneController.text.trim().length >= 7;
  bool get isEmailValid => emailController.text.contains('@');

  void _selectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          dialCode = '+${country.phoneCode}';
        });
      },
    );
  }

  void _clearInput() {
    if (isPhoneSelected) {
      phoneController.clear();
    } else {
      emailController.clear();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                inputNumberOrEmail.toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: vhh(context, 3)),

            // Tab buttons
            Container(
              height: vhh(context, 5),
              decoration: BoxDecoration(
                color: kColorLightGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  _buildTabButton(phone, isPhoneSelected, () {
                    setState(() => isPhoneSelected = true);
                  }),
                  _buildTabButton(email, !isPhoneSelected, () {
                    setState(() => isPhoneSelected = false);
                  }),
                ],
              ),
            ),
            SizedBox(height: vhh(context, 3)),

            Text(
              isPhoneSelected ? phoneNumber : email,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: vhh(context, 2)),

            if (isPhoneSelected)
              Container(
                height: vhh(context, 6),
                decoration: BoxDecoration(
                  color: kColorLightGray,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _selectCountry,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text(dialCode),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    Container(width: 1, color: kColorBorder),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                            inputFormatters: [LengthLimitingTextInputFormatter(11), FilteringTextInputFormatter.digitsOnly,],
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 15),
                              hintText: phoneNumber,
                              border: InputBorder.none,
                            ),
                          ),
                          if (phoneController.text.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.highlight_remove),
                              onPressed: _clearInput,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'example@email.com',
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
                  if (emailController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.highlight_remove),
                      onPressed: _clearInput,
                    ),
                ],
              ),
            ),

            SizedBox(height: vhh(context, 2)),
            GestureDetector(
              onTap: () {
                // Show privacy policy
              },
              child: const Text(
                checkPrivacyPolicy,
                style: TextStyle(
                  color: kColorStrongBlue,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(height: vhh(context, 3)),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (isPhoneSelected ? isPhoneValid : isEmailValid)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Verifyscreen(
                              dialCode: isPhoneSelected ? dialCode : null,
                              phoneNumber: isPhoneSelected ? phoneController.text.trim() : null,
                              email: isPhoneSelected ? null : emailController.text.trim(),
                            )),
                        );
                      }
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

  Widget _buildTabButton(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: vhh(context, 4.7),
          decoration: BoxDecoration(
            color: selected ? kColorWhite : kColorLightGray,
            borderRadius: BorderRadius.circular(8),
            boxShadow: selected
                ? [const BoxShadow(color: Colors.black12, blurRadius: 2)]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.black : Colors.grey[600],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
