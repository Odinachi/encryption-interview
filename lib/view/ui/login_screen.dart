import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/constants.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/resuable_widgets/button.dart';
import 'package:apex/view/resuable_widgets/input_field.dart';
import 'package:apex/view/resuable_widgets/social_card.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: screenHeight(1, context),
          width: screenWidth(1, context),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight(.03, context),
                ),
                Text(
                  AppStrings.heyThere,
                  style: AppAssets.appTextStyle.copyWith(
                      color: AppColors.appDarkColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
                SizedBox(
                  height: screenHeight(.01, context),
                ),
                Text(
                  AppStrings.welcomeSignIn,
                  style: AppAssets.appTextStyle.copyWith(
                    color: AppColors.appGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: screenHeight(.05, context),
                ),
                AppTextFormField(
                  isPassword: false,
                  controller: _emailController,
                  inputName: AppStrings.email,
                ),
                SizedBox(
                  height: screenHeight(.02, context),
                ),
                AppTextFormField(
                  isPassword: true,
                  controller: _passwordController,
                  inputName: AppStrings.password,
                ),
                SizedBox(
                  height: screenHeight(.025, context),
                ),
                Text(
                  AppStrings.forgotPassword,
                  style: AppAssets.appTextStyle.copyWith(
                    color: AppColors.appOrangeColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: screenHeight(.03, context),
                ),
                AppButton(
                  enabled: _passwordController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty,
                  onPress: () {},
                  text: AppStrings.signIn,
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
                const SelectAuthButton(
                  isSignUp: false,
                ),
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
