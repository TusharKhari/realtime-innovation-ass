import 'package:flutter/material.dart';

class OtherStyles {
  static OutlineInputBorder textFiledBorderStyle({
    required Color borderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(width: 1, color: borderColor),
    );
  }
}
