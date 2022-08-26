import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:flutter/material.dart';

class AppRouteStrings {
  static const String home = "/";
  static const String onBoardingScreen = "on-boarding";
  static const String loginScreen = "login";
  static const String signUpScreen = "sign-up";
  static const String verifyOtpScreen = "verify-otp";
  static const String locationScreen = "location";
  static const String pinScreen = "pin";
  static const String congratsScreen = "congrats";
}

class AppStrings {
  static const getStarted = "Get Started";
  static const continueText = "Continue";
  static const proceedToHome = "Proceed to home";
  static const congrats = "Congratulations";
  static String congratsDesc(String name) =>
      "Hey $name, your account has been successfully created 👋 ";
  static const setNewPin = "Set your PIN code";
  static const providePin = "Provide your PIN code";
  static const setNewPinDesc =
      "We use state-of-the-art security measures to protect your information at all times";
  static const email = "Email";
  static const signIn = "Sign In";
  static const verifyYou = "Verify it’s you";
  static const or = "OR";
  static const confirm = "Confirm";
  static const fullName = "Full name";
  static const resendCode = "Resend Code";
  static const createA = "Create a";
  static const smartPay = " Smartpay ";
  static const account = "account";
  static const forgotPassword = "Forgot Password?";
  static const dontHaveAnAccount = "Don’t have an account? ";
  static const areadyHaveAcct = "Already have an account? ";
  static const signUp = "Sign Up";
  static const password = "Password";
  static const search = "Search";
  static const cancel = "Cancel";
  static const countryOfRes = "Country of Residence";
  static const selectAllCountry =
      "Please select all the countries that you’re a tax recident in";
  static const welcomeSignIn = "Welcome back, Sign in to your account";
  static const heyThere = "Hi There! 👋";
  static const skip = "Skip";
  static const onBoardingTitle1 = "Finance app the safest and most trusted";
  static const onBoardingTitle2 = "The fastest transaction process only here";
  static const onBoardingSubtitle1 =
      "Your finance work starts here. Our here to help you track and deal with speeding up your transactions.";
  static const onBoardingSubtitle2 =
      "Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.";

  static RichText weSentCode(String email) => RichText(
        text: TextSpan(
            text: "We send a code to (",
            style: AppAssets.appTextStyle.copyWith(
              color: AppColors.appHintColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text:
                    " *****${email.substring(email.indexOf("@"), email.length)}",
                style: AppAssets.appTextStyle.copyWith(
                  color: AppColors.appDarkColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: "). Enter it here to verify your identity",
                style: AppAssets.appTextStyle.copyWith(
                  color: AppColors.appHintColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              )
            ]),
      );
}
