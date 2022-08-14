import 'package:apex/data/local/storage.dart';
import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/constants.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/resuable_widgets/button.dart';
import 'package:apex/view/resuable_widgets/click_widget.dart';
import 'package:apex/view/ui/onboarding_widget/onboarding_image_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int tab = 0;
  int? k;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    k = 1;
  }

  @override
  Widget build(BuildContext context) {
    void skipOnBoarding() {
      AppStorage.instance.saveSeenSplash(true);
      Navigator.popAndPushNamed(context, AppRouteStrings.loginScreen);
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onPanUpdate: (details) {
              // Swiping in right direction.
              if (details.delta.dx > 0) {
                if (tab != 0) {
                  setState(() {
                    tab = 0;
                  });
                }
              }

              // Swiping in left direction.
              if (details.delta.dx < 0) {
                if (tab != 1) {
                  setState(() {
                    tab = 1;
                  });
                }
              }
              k = null;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClickWidget(
                  onTap: skipOnBoarding,
                  child: SizedBox(
                    child: Text(
                      AppStrings.skip,
                      style: AppAssets.appTextStyle.copyWith(
                          color: AppColors.appOrangeColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      OnBoardingImageStack(
                        index: tab,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 2,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return SlideTransition(
                                    position: Tween(
                                      begin: const Offset(.00, .099),
                                      end: const Offset(0.0, 0.0),
                                    ).animate(animation),
                                    child: AnimatedOpacity(
                                        opacity: k != null
                                            ? 1
                                            : animation.value == 0
                                                ? 1
                                                : 0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: child),
                                  );
                                },
                                child: buildChild(tab),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(.05, context),
                ),
                Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        tab == 0
                            ? AppStrings.onBoardingTitle1
                            : AppStrings.onBoardingTitle2,
                        textAlign: TextAlign.center,
                        style: AppAssets.appTextStyle.copyWith(
                            color: AppColors.appDarkColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(.025, context),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: screenWidth(.7, context),
                      child: Text(
                        tab == 0
                            ? AppStrings.onBoardingSubtitle1
                            : AppStrings.onBoardingSubtitle2,
                        textAlign: TextAlign.center,
                        style: AppAssets.appTextStyle.copyWith(
                            color: AppColors.appGrey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight(.035, context),
                ),
                SizedBox(
                  height: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                        itemCount: 2,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: tab == i
                                ? AppColors.appDarkColor
                                : AppColors.appGrey.withOpacity(.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 6,
                          width: tab == i ? 32 : 6,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(.05, context),
                ),
                AppButton(
                  onPress: skipOnBoarding,
                  text: AppStrings.getStarted,
                  enabled: true,
                ),
                SizedBox(
                  height: screenHeight(.04, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildChild(index) => Align(
      alignment: Alignment.topCenter,
      key: ValueKey('$index'),
      child: index == 0
          ? SvgPicture.asset(AppAssets.upperSplash1)
          : SvgPicture.asset(AppAssets.upperSplash2));
}
