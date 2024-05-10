import 'package:device_info_plus/device_info_plus.dart';
import '../models/common/device_info_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MetaDeviceData {
  static Future<IosDeviceInfo> getIOSInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo;
  }

  static Future<AndroidDeviceInfo> getAndroidInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo;
  }

  static Future<MacOsDeviceInfo> getMacOSInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    MacOsDeviceInfo macInfo = await deviceInfo.macOsInfo;
    return macInfo;
  }

  static Future<WindowsDeviceInfo> getWindowsOSInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
    return windowsInfo;
  }

  static Future<LinuxDeviceInfo> getLinuxOSInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
    return linuxInfo;
  }

  void getDeviceInfoData(ValueSetter<DeviceInfoModel?> completion) {
    if (Platform.isIOS) {
      getIOSInfo().then((info) {
        completion(
          DeviceInfoModel(
            id: info.identifierForVendor ?? '',
            name: info.model ?? '',
            type: 'ios',
            version: info.systemVersion ?? '',
          ),
        );
      });
    } else if (Platform.isAndroid) {
      getAndroidInfo().then((info) {
        completion(
          DeviceInfoModel(
            id: info.id,
            name: info.brand,
            type: 'android',
            version: info.version.incremental,
          ),
        );
      });
    } else if (Platform.isMacOS) {
      getMacOSInfo().then((info) {
        completion(
          DeviceInfoModel(
            id: info.data['systemGUID'],
            name: info.computerName,
            type: 'macos',
            version: info.osRelease,
          ),
        );
      });
    } else if (Platform.isWindows) {
      getWindowsOSInfo().then((info) {
        completion(
          DeviceInfoModel(
            id: '',
            name: '',
            type: '',
            version: '',
          ),
        );
      });
    } else if (Platform.isLinux) {
      getLinuxOSInfo().then((info) {
        completion(
          DeviceInfoModel(
            id: '',
            name: '',
            type: '',
            version: '',
          ),
        );
      });
    }
  }
}
