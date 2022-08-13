import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/constants.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/resuable_widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: screenHeight(1, context),
          width: screenWidth(1, context),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppAssets.welcomeIcon),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    AppStrings.congrats,
                    textAlign: TextAlign.center,
                    style: AppAssets.appTextStyle.copyWith(
                      color: AppColors.appDarkColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: screenWidth(.6, context),
                    child: Text(
                      AppStrings.congratsDesc("Jamal"),
                      textAlign: TextAlign.center,
                      style: AppAssets.appTextStyle.copyWith(
                        color: AppColors.appHintColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              )),
              AppButton(
                text: AppStrings.proceedToHome,
                onPress: () => Navigator.pushNamedAndRemoveUntil(
                    context, AppRouteStrings.home, (route) => false),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
