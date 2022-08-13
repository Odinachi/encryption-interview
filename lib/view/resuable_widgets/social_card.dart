import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/resuable_widgets/click_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget socialAuthCard(String icon, VoidCallback callback) {
  return Expanded(
    child: ClickWidget(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.appGrey.withOpacity(.3)),
        ),
        child: SvgPicture.asset(icon),
      ),
    ),
  );
}

Widget decorWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 10, left: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, AppColors.appGrey.withOpacity(.8)]),
          ),
          height: 1,
        ),
      ),
      Text(
        AppStrings.or,
        style: AppAssets.appTextStyle.copyWith(
          color: AppColors.appDarkColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColors.appGrey.withOpacity(.8),
              Colors.white,
            ]),
          ),
          height: 1,
        ),
      ),
    ],
  );
}

class SelectAuthButton extends StatelessWidget {
  const SelectAuthButton({Key? key, this.isSignUp = true}) : super(key: key);
  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: isSignUp
              ? AppStrings.areadyHaveAcct
              : AppStrings.dontHaveAnAccount,
          style: AppAssets.appTextStyle.copyWith(
            color: AppColors.appDarkColor,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: isSignUp ? AppStrings.signIn : AppStrings.signUp,
              style: AppAssets.appTextStyle.copyWith(
                color: AppColors.appOrangeColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pushReplacementNamed(
                      context,
                      isSignUp
                          ? AppRouteStrings.loginScreen
                          : AppRouteStrings.signUpScreen,
                    ),
            )
          ],
        ),
      ),
    );
  }
}

AppBar apexAppBar({VoidCallback? onTap}) {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        ClickWidget(onTap: onTap, child: SvgPicture.asset(AppAssets.backIcon)),
      ],
    ),
  );
}
