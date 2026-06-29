import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceHelper {
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;

      return {
        "deviceName": "${android.manufacturer} ${android.model}",
        "platform": "Android",
        "osVersion": android.version.release,
      };
    }
    if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      return {
        "deviceName": ios.utsname.machine,
        "platform": "iOS",
        "osVersion": ios.systemVersion,
      };
    }
    return {
      "deviceName": "Unknown",
      "platform": Platform.operatingSystem,
      "osVersion": Platform.operatingSystemVersion,
    };
  }
}
