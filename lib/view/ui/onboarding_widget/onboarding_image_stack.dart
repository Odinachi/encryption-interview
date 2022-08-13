import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:flutter/material.dart';

class OnBoardingImageStack extends StatelessWidget {
  const OnBoardingImageStack({Key? key, this.index = 0}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          margin: const EdgeInsets.only(
            top: 100,
          ),
          padding: const EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(index == 0
                      ? AppAssets.onBoardingDevice1
                      : AppAssets.onBoardingDevice2))),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(
            top: 100,
          ),
          padding: const EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.white.withOpacity(.01),
                AppColors.white.withOpacity(.01),
                AppColors.white.withOpacity(.1),
                AppColors.backgroundColor
              ],
            ),
          ),
        ),
      ],
    );
  }
}
