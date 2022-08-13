import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/view/resuable_widgets/click_widget.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField(
      {Key? key,
      this.controller,
      this.validate,
      this.inputName = "",
      this.isPassword = false})
      : super(key: key);
  final TextEditingController? controller;
  final String inputName;
  final bool isPassword;
  final String? Function(String? v)? validate;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    if (widget.isPassword) {
      showPassword = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: showPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validate,
      controller: widget.controller,
      cursorHeight: 25,
      cursorColor: AppColors.appDarkColor,
      style: AppAssets.appTextStyle.copyWith(
        color: AppColors.appDarkColor,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        letterSpacing: .5,
      ),
      decoration: InputDecoration(
        filled: true,
        hintText: widget.inputName,
        hintStyle: AppAssets.appTextStyle.copyWith(
          color: AppColors.appHintColor,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        fillColor: AppColors.appFillColor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              const BorderSide(color: AppColors.appOrangeColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              const BorderSide(color: AppColors.appOrangeColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        suffixIcon: ClickWidget(
          onTap: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          child: widget.isPassword
              ? Icon(
                  showPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 26,
                  color: AppColors.appHintColor,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

extension Validator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
        .hasMatch(this);
  }
}
