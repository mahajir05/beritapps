import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtils {
  static Future<AndroidDeviceInfo> androidDeviceInfo() async {
    var deviceInfoPlugin = DeviceInfoPlugin();
    return deviceInfoPlugin.androidInfo;
  }

  static Future<IosDeviceInfo> iosDeviceInfo() async {
    var deviceInfoPlugin = DeviceInfoPlugin();
    return deviceInfoPlugin.iosInfo;
  }
}
