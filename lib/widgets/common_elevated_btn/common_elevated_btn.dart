import 'package:flutter/material.dart';
import 'package:real_time_innovation/utils/text_styles.dart';

class CommonElevatedButton extends StatelessWidget {
  final String btnName;
  final Color btnBgColor;
  final Color btnTextColor;
  final Function() onPressed;
  const CommonElevatedButton({
    super.key,
    required this.btnName,
    required this.btnTextColor,
    required this.btnBgColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: btnBgColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        btnName,
        style: TextStyles.kFontStyleW500S16.copyWith(
          fontSize: 14,
          color: btnTextColor,
        ),
      ),
    );
  }
}
