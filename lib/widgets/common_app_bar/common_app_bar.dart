import 'package:flutter/material.dart';
import 'package:real_time_innovation/constants/app_string.dart';

class CommonAppBar extends StatelessWidget {
  final String appBarTitle;
  final Widget? trailingWidget;
  final bool autoImplementLeading;
  const CommonAppBar({
    super.key,
    required this.appBarTitle,
    this.trailingWidget,
    this.autoImplementLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppBar(
      automaticallyImplyLeading: autoImplementLeading,
      title: Text(
        appBarTitle,
        style: textTheme.displayLarge,
      ),
      actions: trailingWidget == null
          ? null
          : [
              trailingWidget!,
              const SizedBox(width: 21.5),
            ],
    );
  }
}
