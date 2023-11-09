import 'package:flutter/material.dart';
import 'package:real_time_innovation/constants/colors.dart';
import 'package:real_time_innovation/constants/image_paths.dart';
import 'package:real_time_innovation/utils/text_styles.dart';

class DateSelectionWidget extends StatelessWidget {
  final String hintText;
  final String? valueText;
  final Function() onTap;
  const DateSelectionWidget({
    super.key,
    required this.hintText,
    this.valueText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.kTextFildInActiveBorderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(11.5, 10.38, 0, 10.5),
                child: Image.asset(
                  ImagePaths.calendarIcon,
                  width: 17,
                  height: 19.12,
                ),
              ),
              const SizedBox(
                width: 9.68,
              ),
              Text(
                valueText == null || valueText!.isEmpty ? hintText : valueText!,
                style: TextStyles.kFontStyleW500S16.copyWith(
                  fontSize: 14,
                  color: valueText == null || valueText!.isEmpty
                      ? null
                      : const Color(0xff323238),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
