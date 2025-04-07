import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seetle/firebase_options.dart';
import 'package:seetle/src/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Seetle",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await Firebase.initializeApp();
  runApp(const ProviderScope(child: seetle()));
}