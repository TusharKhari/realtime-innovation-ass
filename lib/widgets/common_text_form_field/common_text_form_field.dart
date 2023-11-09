import 'package:flutter/material.dart';
import 'package:real_time_innovation/constants/colors.dart';
import 'package:real_time_innovation/utils/other_styles.dart';
import 'package:real_time_innovation/utils/text_styles.dart';

class CommonTextFormField extends StatelessWidget {
  final Widget prefixWidget;
  final String hintText;
  final Widget? suffixWidget;
  final bool isEnable;
  final TextEditingController? textEditingController;
  const CommonTextFormField({
    super.key,
    required this.hintText,
    required this.prefixWidget,
    this.suffixWidget,
    this.isEnable = true,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        enabled: isEnable,
        controller: textEditingController,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyles.kFontStyleW500S16.copyWith(
          color: const Color(0xff323238),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: OtherStyles.textFiledBorderStyle(
            borderColor: AppColors.kDefaultAppColorBlue,
          ),
          enabledBorder: OtherStyles.textFiledBorderStyle(
            borderColor: AppColors.kTextFildInActiveBorderColor,
          ),
          prefixIcon: prefixWidget,
          hintText: hintText,
          hintStyle: TextStyles.kFontStyleW500S16,
          suffixIcon: suffixWidget,
        ),
      ),
    );
  }
}
