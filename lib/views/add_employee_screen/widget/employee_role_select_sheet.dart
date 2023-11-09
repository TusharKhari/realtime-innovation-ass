import 'package:flutter/material.dart';
import 'package:real_time_innovation/utils/text_styles.dart';

class EmployeeRoleSelectSheetWidget extends StatelessWidget {
  EmployeeRoleSelectSheetWidget({
    super.key,
    required this.size,
    required this.onTap,
  });
  final Function(String) onTap;
  final Size size;
  final List<String> _data = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.3,
      child: ListView.separated(
        itemCount: _data.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (_, i) {
          return GestureDetector(
            onTap: () => onTap(_data[i]),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                _data[i],
                style: TextStyles.kFontStyleW500S16.copyWith(
                  color: const Color(0xff323238),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
