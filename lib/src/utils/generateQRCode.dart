import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;

class DeviceQRGenerator {
  static Future<String> generateDeviceData() async {
    final deviceInfo = DeviceInfoPlugin();

    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await deviceInfo.androidInfo;
        return '''
Android Device
Model: ${androidInfo.model}
Manufacturer: ${androidInfo.manufacturer}
OS: ${androidInfo.version.release}
''';
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return '''
iOS Device
Model: ${iosInfo.model}
System: ${iosInfo.systemVersion}
Name: ${iosInfo.name}
''';
      }
      return 'Unknown device type';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
