import 'package:apex/res/assets.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/view/resuable_widgets/click_widget.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      this.enabled = true,
      this.text = "",
      this.onPress,
      this.loading = false})
      : super(key: key);

  final bool enabled;
  final String text;
  final bool loading;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return ClickWidget(
      onTap: enabled ? onPress : null,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: enabled
                    ? AppColors.appDarkColor
                    : AppColors.appDarkColor.withOpacity(.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: !loading
                  ? Text(
                      text,
                      textAlign: TextAlign.center,
                      style: AppAssets.appTextStyle.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    )
                  : Column(
                      children: const [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
