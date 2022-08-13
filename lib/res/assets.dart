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
}
