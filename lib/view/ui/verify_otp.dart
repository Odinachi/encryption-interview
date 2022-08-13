import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/constants.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/resuable_widgets/button.dart';
import 'package:apex/view/resuable_widgets/click_widget.dart';
import 'package:apex/view/resuable_widgets/social_card.dart';
import 'package:apex/view/ui/location_screen.dart';
import 'package:apex/view_model/blocs/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class VerifyOtp extends StatelessWidget {
  const VerifyOtp(
      {Key? key,
      required this.email,
      required this.password,
      required this.fullname})
      : super(key: key);
  final String fullname;
  final String email;
  final String password;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyOtpBloc(),
      child: _VerifyOtp(
        fullname: fullname,
        email: email,
        password: password,
      ),
    );
  }
}

class _VerifyOtp extends StatefulWidget {
  _VerifyOtp(
      {Key? key,
      required this.email,
      required this.password,
      required this.fullname})
      : super(key: key);
  final String fullname;
  final String email;
  final String password;

  @override
  State<_VerifyOtp> createState() => __VerifyOtpState();
}

class __VerifyOtpState extends State<_VerifyOtp> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: apexAppBar(onTap: () => Navigator.pop(context)),
      body: BlocListener<VerifyOtpBloc, VerifyOtpState>(
        listener: (context, state) {
          if (state is VerifyOtpFailed) {
            AppAssets.showSnackBar(
                ctx: context, isSuccessful: false, message: state.error);
          }
          if (state is VerifyOtpSuccess) {
            Navigator.pushNamed(
              context,
              AppRouteStrings.locationScreen,
              arguments: LocationScreenArg(
                password: widget.password,
                email: widget.email,
                fullName: widget.fullname,
              ),
            );
          }
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    AppStrings.verifyYou,
                    style: AppAssets.appTextStyle.copyWith(
                      color: AppColors.appDarkColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(.01, context),
                  ),
                  AppStrings.weSentCode(widget.email),
                  SizedBox(
                    height: screenHeight(.035, context),
                  ),
                  PinCodeTextField(
                    focusNode: _pinNode,
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                    validator: (g) {
                      if (g?.length != 5) {
                        return "Invalid Pin";
                      }
                      return null;
                    },
                    showCursor: false,
                    autoFocus: false,
                    textStyle: AppAssets.appTextStyle.copyWith(
                      color: AppColors.appDarkColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        activeFillColor: AppColors.appFillColor,
                        inactiveFillColor: AppColors.appFillColor,
                        selectedFillColor: AppColors.appFillColor,
                        selectedColor: AppColors.appOrangeColor,
                        activeColor: AppColors.appFillColor,
                        inactiveColor: AppColors.appFillColor,
                        fieldWidth: 55,
                        fieldHeight: 55),
                    onChanged: (String value) {},
                    length: 5,
                    appContext: context,
                  ),
                  SizedBox(
                    height: screenHeight(.01, context),
                  ),
                  Center(
                    child: ClickWidget(
                      onTap: () {
                        context.read<VerifyOtpBloc>().add(
                              ResendEvent(email: widget.email),
                            );
                      },
                      child: Text(
                        AppStrings.resendCode,
                        style: AppAssets.appTextStyle.copyWith(
                          color: AppColors.appOrangeColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(.06, context),
                  ),
                  BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
                    buildWhen: (prev, next) {
                      if (prev is VerifyOtpLoading) {
                        return true;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      bool l = false;
                      if (state is VerifyOtpLoading) {
                        l = true;
                      } else {
                        l = false;
                      }
                      return AppButton(
                        loading: l,
                        enabled: _pinController.text.length == 5 &&
                            state is! VerifyOtpLoading,
                        onPress: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<VerifyOtpBloc>().add(VerifyEvent(
                                token: _pinController.text,
                                email: widget.email));
                          }
                        },
                        text: AppStrings.confirm,
                      );
                    },
                  ),
                  SizedBox(
                    height: screenHeight(.05, context),
                  ),
                  Expanded(
                    child: VirtualKeyboard(
                      type: VirtualKeyboardType.Numeric,
                      fontSize: 24,
                      onKeyPress: (VirtualKeyboardKey k) {
                        if (k.keyType == VirtualKeyboardKeyType.Action) {
                          switch (k.action) {
                            case VirtualKeyboardKeyAction.Backspace:
                              if (_pinController.text.isEmpty) return;
                              _pinController.text = _pinController.text
                                  .substring(0, _pinController.text.length - 1);
                              break;

                            default:
                          }
                        } else if (k.keyType == VirtualKeyboardKeyType.String) {
                          if (_pinController.text.length > 4) return;
                          _pinController.text += "${k.text}";
                        }

                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VerifyOtpArg {
  final String fullname;
  final String email;
  final String password;
  VerifyOtpArg(
      {required this.email, required this.password, required this.fullname});
}
