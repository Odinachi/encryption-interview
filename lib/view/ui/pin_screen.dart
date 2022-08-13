import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/constants.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/resuable_widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

import '../resuable_widgets/click_widget.dart';
import '../resuable_widgets/social_card.dart';

class PinScreen extends StatefulWidget {
  PinScreen({Key? key}) : super(key: key);

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight(.03, context),
              ),
              Text(
                AppStrings.setNewPin,
                style: AppAssets.appTextStyle.copyWith(
                  color: AppColors.appDarkColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: screenHeight(.01, context),
              ),
              Text(
                AppStrings.setNewPinDesc,
                style: AppAssets.appTextStyle.copyWith(
                  color: AppColors.appHintColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: screenHeight(.035, context),
              ),
              PinCodeTextField(
                focusNode: _pinNode,
                cursorColor: AppColors.appOrangeColor,
                controller: _pinController,
                keyboardType: TextInputType.number,
                enableActiveFill: false,
                validator: (g) {},
                autoFocus: false,
                obscureText: true,
                showCursor: true,
                textStyle: AppAssets.appTextStyle.copyWith(
                  color: AppColors.appDarkColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
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
                onPress: () => Navigator.pushNamed(
                    context, AppRouteStrings.congratsScreen),
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
}
