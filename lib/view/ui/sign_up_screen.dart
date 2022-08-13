import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/constants.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/resuable_widgets/button.dart';
import 'package:apex/view/resuable_widgets/input_field.dart';
import 'package:apex/view/resuable_widgets/social_card.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fullNameController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: apexAppBar(
        onTap: () =>
            Navigator.pushNamed(context, AppRouteStrings.verifyOtpScreen),
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: screenHeight(1, context),
            width: screenWidth(1, context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight(.02, context),
                ),
                RichText(
                  text: TextSpan(
                      style: AppAssets.appTextStyle.copyWith(
                        color: AppColors.appDarkColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                      text: AppStrings.createA,
                      children: [
                        TextSpan(
                          text: AppStrings.smartPay,
                          style: AppAssets.appTextStyle.copyWith(
                            color: AppColors.appOrangeColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        )
                      ]),
                ),
                Text(
                  AppStrings.account,
                  style: AppAssets.appTextStyle.copyWith(
                    color: AppColors.appDarkColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: screenHeight(.04, context),
                ),
                AppTextFormField(
                  inputName: AppStrings.fullName,
                  controller: _fullNameController,
                  isPassword: false,
                ),
                SizedBox(
                  height: screenHeight(.02, context),
                ),
                AppTextFormField(
                  inputName: AppStrings.email,
                  controller: _emailController,
                  isPassword: false,
                ),
                SizedBox(
                  height: screenHeight(.02, context),
                ),
                AppTextFormField(
                  inputName: AppStrings.password,
                  controller: _passwordController,
                  isPassword: true,
                ),
                SizedBox(
                  height: screenHeight(.03, context),
                ),
                AppButton(
                  enabled: _emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty &&
                      _fullNameController.text.isNotEmpty,
                  text: AppStrings.signUp,
                  onPress: () {
                    Navigator.pushNamed(
                        context, AppRouteStrings.verifyOtpScreen);
                  },
                ),
                SizedBox(
                  height: screenHeight(.03, context),
                ),
                decorWidget(),
                SizedBox(
                  height: screenHeight(.02, context),
                ),
                Row(
                  children: [
                    socialAuthCard(AppAssets.googleIcon, () {}),
                    const SizedBox(
                      width: 20,
                    ),
                    socialAuthCard(AppAssets.appleIcon, () {}),
                  ],
                ),
                const Expanded(child: SizedBox()),
                const SelectAuthButton(),
                SizedBox(
                  height: screenHeight(.02, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
