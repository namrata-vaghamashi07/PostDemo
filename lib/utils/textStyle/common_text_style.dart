import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/colors/custom_color.dart';

class CommonTextStyles {
  static TextStyle postListSubText = TextStyle(
      fontSize: 14,
      color: CustomColor.blackColor.withOpacity(0.4),
      fontWeight: FontWeight.w500);
  static TextStyle postListTitle = TextStyle(
      fontSize: 16, color: CustomColor.blackColor, fontWeight: FontWeight.w500);

  static TextStyle postDetailTitle = TextStyle(
      fontSize: 22, color: CustomColor.blackColor, fontWeight: FontWeight.w600);

  static TextStyle postDetailSubText = TextStyle(
      fontSize: 16,
      color: CustomColor.greyColor.withOpacity(0.9),
      fontWeight: FontWeight.w500);
}
