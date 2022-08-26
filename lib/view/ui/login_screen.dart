import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/constants.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/resuable_widgets/button.dart';
import 'package:apex/view/resuable_widgets/input_field.dart';
import 'package:apex/view/resuable_widgets/social_card.dart';
import 'package:apex/view/ui/pin_screen.dart';
import 'package:apex/view_model/blocs/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(CheckAuth()),
      child: const _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatefulWidget {
  const _LoginScreen({Key? key}) : super(key: key);

  @override
  State<_LoginScreen> createState() => __LoginScreenState();
}

class __LoginScreenState extends State<_LoginScreen> {
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
      resizeToAvoidBottomInset: false,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is HasAuth) {
            Navigator.pushNamed(
              context,
              AppRouteStrings.pinScreen,
              arguments: PinScreenArg(newUser: false, token: ""),
            );
          }

          if (state is LoginSuccess) {
            Navigator.pushNamed(
              context,
              AppRouteStrings.pinScreen,
              arguments: PinScreenArg(newUser: true, token: state.token),
            );
          }
        },
        child: SafeArea(
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
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                    if (state is LoginFailed) {
                      return Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          state.error,
                          textAlign: TextAlign.center,
                          style: AppAssets.appTextStyle.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.red),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                  SizedBox(
                    height: screenHeight(.03, context),
                  ),
                  AppTextFormField(
                    isPassword: false,
                    controller: _emailController,
                    inputName: AppStrings.email,
                    validate: (v) => v?.isValidEmail() == true
                        ? null
                        : "Provide a valid Email",
                  ),
                  SizedBox(
                    height: screenHeight(.02, context),
                  ),
                  AppTextFormField(
                      isPassword: true,
                      controller: _passwordController,
                      inputName: AppStrings.password,
                      validate: (v) => v?.isValidPassword() == true
                          ? null
                          : "Provide a valid Password"),
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
                  BlocBuilder<LoginBloc, LoginState>(buildWhen: (prev, next) {
                    if (prev is LoginLoading) {
                      return true;
                    }
                    return true;
                  }, builder: (context, state) {
                    bool l = false;
                    if (state is LoginLoading) {
                      l = true;
                    } else {
                      l = false;
                    }
                    return AppButton(
                      loading: l,
                      enabled: _formKey.currentState?.validate() == true,
                      onPress: () {
                        if (_formKey.currentState?.validate() == true) {
                          context.read<LoginBloc>().add(Login(
                              email: _emailController.text,
                              password: _passwordController.text));
                        }
                      },
                      text: AppStrings.signIn,
                    );
                  }),
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
      ),
    );
  }
}
