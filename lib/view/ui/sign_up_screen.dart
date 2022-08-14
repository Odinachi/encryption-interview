import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/constants.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/resuable_widgets/button.dart';
import 'package:apex/view/resuable_widgets/input_field.dart';
import 'package:apex/view/resuable_widgets/social_card.dart';
import 'package:apex/view/ui/verify_otp.dart';
import 'package:apex/view_model/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: const _SignUpScreen(),
    );
  }
}

class _SignUpScreen extends StatefulWidget {
  const _SignUpScreen({Key? key}) : super(key: key);

  @override
  State<_SignUpScreen> createState() => __SignUpScreenState();
}

class __SignUpScreenState extends State<_SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: apexAppBar(
        onTap: () => Navigator.pushReplacementNamed(
            context, AppRouteStrings.loginScreen),
      ),
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailed) {
            AppAssets.showSnackBar(
                ctx: context, isSuccessful: false, message: state.error);
          }
          if (state is SignUpSuccess) {
            Navigator.pushNamed(context, AppRouteStrings.verifyOtpScreen,
                arguments: VerifyOtpArg(
                  fullname: _fullNameController.text,
                  password: _passwordController.text,
                  email: _emailController.text,
                ));
          }
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
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
                    validate: (v) {
                      if (v!.length < 5) {
                        return "Input a valid password";
                      }
                      if (!v.contains(" ")) {
                        return "Input  valid Names";
                      }
                      return null;
                    },
                    inputName: AppStrings.fullName,
                    controller: _fullNameController,
                    isPassword: false,
                  ),
                  SizedBox(
                    height: screenHeight(.02, context),
                  ),
                  AppTextFormField(
                    validate: (v) =>
                        v?.isValidEmail() == true ? null : "Check your email",
                    inputName: AppStrings.email,
                    controller: _emailController,
                    isPassword: false,
                  ),
                  SizedBox(
                    height: screenHeight(.02, context),
                  ),
                  AppTextFormField(
                    validate: (v) => v?.isValidPassword() == true
                        ? null
                        : "Password not strong enough",
                    inputName: AppStrings.password,
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: screenHeight(.03, context),
                  ),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (prev, next) {
                      if (prev is SignUpLoading) {
                        return true;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      bool l = false;
                      if (state is SignUpLoading) {
                        l = true;
                      } else {
                        l = false;
                      }

                      return AppButton(
                        loading: l,
                        enabled: _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _fullNameController.text.isNotEmpty &&
                            state is! SignUpLoading,
                        text: AppStrings.signUp,
                        onPress: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<SignUpBloc>().add(RegisterEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                                fullname: _fullNameController.text,
                                country: "NG"));
                          }
                        },
                      );
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
      ),
    );
  }
}
