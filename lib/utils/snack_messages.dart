import 'package:flutter/material.dart';
import 'package:real_time_innovation/constants/colors.dart';
import 'package:real_time_innovation/constants/keys.dart';

class SnackMessages {
  static showSnackMessgae(
      {required String msg,
      required String btnName,
      required Function() onPressed}) {
    snackKey.currentState!.hideCurrentSnackBar();
    snackKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: btnName,
          textColor: AppColors.kDefaultAppColorBlue,
          onPressed: onPressed,
        ),
        duration: const Duration(seconds: 7),
      ),
    );
  }
}
