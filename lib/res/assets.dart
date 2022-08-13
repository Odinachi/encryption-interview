import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class AppAssets {
  static const String _iconPaths = "assets/svgs/";
  static const String _imagePaths = "assets/pngs/";

  //images
  static const String onBoardingDevice1 = "${_imagePaths}device.png";
  static const String onBoardingDevice2 = "${_imagePaths}device-2.png";

  //icons
  static const String upperSplash1 = "${_iconPaths}upper-splash-1.svg";
  static const String upperSplash2 = "${_iconPaths}upper-splash-2.svg";
  static const String backIcon = "${_iconPaths}back.svg";
  static const String googleIcon = "${_iconPaths}google-icon.svg";
  static const String appleIcon = "${_iconPaths}apple.svg";
  static const String searchIcon = "${_iconPaths}search.svg";
  static const String welcomeIcon = "${_iconPaths}welcome-icon.svg";

  static const TextStyle appTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: "sf-pro",
    fontWeight: FontWeight.w500,
    letterSpacing: .5,
  );
  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return "";
  }

  static void showSnackBar(
      {required BuildContext ctx,
      String? message,
      required bool isSuccessful}) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          message ?? "",
          style:
              appTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        backgroundColor: isSuccessful ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.fromLTRB(
            20, 20, 20, MediaQuery.of(ctx).size.height - 130),
      ),
    );
  }
}
