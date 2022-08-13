import 'package:apex/view/ui/congrats_screen.dart';
import 'package:apex/view/ui/home_screen.dart';
import 'package:apex/view/ui/onboarding_screen.dart';
import 'package:apex/view/ui/pin_screen.dart';
import 'package:apex/view/ui/sign_up_screen.dart';
import 'package:apex/view/ui/verify_otp.dart';
import 'package:flutter/material.dart';

import '../res/strings.dart';
import 'ui/location_screen.dart';
import 'ui/login_screen.dart';

Route appRoutes(RouteSettings settings) {
  Widget builder = Container();
  switch (settings.name) {
    case AppRouteStrings.home:
      builder = const HomeScreen();
      break;
    case AppRouteStrings.onBoardingScreen:
      builder = const OnBoardingScreen();
      break;
    case AppRouteStrings.loginScreen:
      builder = const LoginScreen();
      break;
    case AppRouteStrings.signUpScreen:
      builder = const SignUpScreen();
      break;
    case AppRouteStrings.verifyOtpScreen:
      VerifyOtpArg arg = settings.arguments as VerifyOtpArg;
      builder = VerifyOtp(
        fullname: arg.fullname,
        email: arg.email,
        password: arg.password,
      );

      break;
    case AppRouteStrings.locationScreen:
      LocationScreenArg args = settings.arguments as LocationScreenArg;
      builder = LocationScreen(
        email: args.email,
        password: args.password,
        fullName: args.fullName,
      );

      break;
    case AppRouteStrings.pinScreen:
      PinScreenArg arg = settings.arguments as PinScreenArg;
      builder = PinScreen(
        token: arg.token,
        newUser: arg.newUser,
      );
      break;
    case AppRouteStrings.congratsScreen:
      builder = const CongratsScreen();
      break;

    default:
      throw Exception('Invalid route: ${settings.name}');
  }
  return MaterialPageRoute(builder: (context) => builder);
}
