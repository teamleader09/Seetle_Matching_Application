import 'package:settee/src/translate/jp.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

class Common {

  static void showSuccessMessage(String msg, BuildContext context) {
    toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        title: Text(msg, style: const TextStyle(fontSize: 12),),
        primaryColor: Colors.green,
        foregroundColor: Colors.black,
        showProgressBar: false,
        animationDuration: const Duration(milliseconds: 300),
        autoCloseDuration: const Duration(seconds: 3),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
  }

  static void showErrorMessage(String msg, BuildContext context) {
    toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        title: Text(msg, style: const TextStyle(fontSize: 12),),
        primaryColor: Colors.red,
        foregroundColor: Colors.black,
        showProgressBar: false,
        animationDuration: const Duration(milliseconds: 300),
        autoCloseDuration: const Duration(seconds: 3),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing it manually
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(), // Spinner
              SizedBox(height: 20),
              Text(
                loadingBar,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}