import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/constants.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/resuable_widgets/button.dart';
import 'package:apex/view/resuable_widgets/click_widget.dart';
import 'package:apex/view/resuable_widgets/social_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

class VerifyOtp extends StatefulWidget {
  VerifyOtp({Key? key}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: apexAppBar(onTap: () => Navigator.pop(context)),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: screenHeight(1, context),
          width: screenWidth(1, context),
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
              AppStrings.weSentCode("email@email.com"),
              SizedBox(
                height: screenHeight(.035, context),
              ),
              PinCodeTextField(
                focusNode: _pinNode,
                controller: _pinController,
                keyboardType: TextInputType.number,
                enableActiveFill: true,
                validator: (g) {},
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
                  onTap: () {},
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
              AppButton(
                enabled: _pinController.text.length == 5,
                onPress: () {
                  Navigator.pushNamed(context, AppRouteStrings.locationScreen);
                },
                text: AppStrings.confirm,
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
    );
  }

  _onKeyPress(VirtualKeyboardKey key) {
    String text = _pinController.text;
    if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text.isEmpty) return;
          text = text.substring(0, text.length - 1);
          break;

        default:
      }
    }
// Update the screen
  }
}