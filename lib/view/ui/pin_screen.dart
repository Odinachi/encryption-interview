import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/constants.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/resuable_widgets/button.dart';
import 'package:apex/view_model/blocs/pin_bloc/pin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

import '../resuable_widgets/social_card.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({Key? key, required this.token, required this.newUser})
      : super(key: key);
  final String token;
  final bool newUser;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PinBloc(),
      child: _PinScreen(
        token: token,
        newUser: newUser,
      ),
    );
  }
}

class _PinScreen extends StatefulWidget {
  _PinScreen({Key? key, required this.token, required this.newUser})
      : super(key: key);
  final String token;
  final bool newUser;
  @override
  State<_PinScreen> createState() => __PinScreenState();
}

class __PinScreenState extends State<_PinScreen> {
  final TextEditingController _pinController = TextEditingController();

  final FocusNode _pinNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _pinNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: apexAppBar(onTap: () => Navigator.pop(context)),
      body: BlocListener<PinBloc, PinState>(
        listener: (context, state) {
          if (state is PinFailed) {
            AppAssets.showSnackBar(
                ctx: context, isSuccessful: false, message: state.error);
          }
          if (state is PinSuccess) {
            if (widget.newUser == true) {
              Navigator.pushNamed(
                context,
                AppRouteStrings.congratsScreen,
              );
            } else {
              Navigator.pushNamed(context, AppRouteStrings.home);
            }
          }
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight(.03, context),
                  ),
                  Text(
                    widget.newUser == true
                        ? AppStrings.setNewPin
                        : AppStrings.providePin,
                    style: AppAssets.appTextStyle.copyWith(
                      color: AppColors.appDarkColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(.01, context),
                  ),
                  if (widget.newUser == true)
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
                    keyboardType: TextInputType.none,
                    enableActiveFill: false,
                    validator: (g) => _pinController.text.length == 5
                        ? null
                        : "Input valid pin",
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
                        activeFillColor: AppColors.appOrangeColor,
                        inactiveFillColor: AppColors.appOrangeColor,
                        selectedFillColor: AppColors.appOrangeColor,
                        selectedColor: AppColors.appOrangeColor,
                        activeColor: AppColors.appOrangeColor,
                        inactiveColor: AppColors.appOrangeColor,
                        fieldWidth: 55,
                        fieldHeight: 55),
                    onChanged: (String value) {},
                    length: 5,
                    appContext: context,
                  ),
                  SizedBox(
                    height: screenHeight(.01, context),
                  ),
                  SizedBox(
                    height: screenHeight(.06, context),
                  ),
                  AppButton(
                    enabled: _pinController.text.length == 5,
                    onPress: () {
                      if (_formKey.currentState?.validate() == true) {
                        if (widget.newUser == true) {
                          context.read<PinBloc>().add(SaveEvent(
                              pincode: _pinController.text,
                              token: widget.token));
                        } else {
                          context
                              .read<PinBloc>()
                              .add(LoginEvent(pincode: _pinController.text));
                        }
                      }
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
        ),
      ),
    );
  }
}

class PinScreenArg {
  final String token;
  final bool newUser;
  PinScreenArg({required this.token, required this.newUser});
}
