import 'package:email_otp/email_otp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendOTPController extends StateNotifier<AsyncValue<bool>>{

  SendOTPController() : super(const AsyncData(false));

  Future<bool> sendOtpWithCloudFunction(String email) async {
    if (await EmailOTP.sendOTP(email: email)) {
      return true;
    } else {
      return false;
    }
  }
}
