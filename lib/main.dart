import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settee/firebase_options.dart';
import 'package:settee/src/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Seetle",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  EmailOTP.config(
    appName: 'Seetle',
    otpType: OTPType.numeric,
    emailTheme: EmailTheme.v6,
  );
  runApp(const ProviderScope(child: settee()));
}