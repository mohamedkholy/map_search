import 'package:flutter/material.dart';
import 'package:map_search/core/theming/font_weight_helper.dart';
import 'package:map_search/core/theming/my_colors.dart';

abstract class MyTextStyles {
  static const TextStyle appBarTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static const fontAmiriBold = TextStyle(
    fontFamily: "Amiri",
    fontWeight: FontWeight.bold,
  );

  static const font15RegularGrey = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightHelper.regular,
    color: Colors.grey,
  );

  static const TextStyle font20PrimarySemiBold = TextStyle(
    fontSize: 25,
    color: MyColors.primary,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font15greyRegular = TextStyle(
    fontSize: 17,
    color: Colors.grey.shade600,
    fontWeight: FontWeightHelper.medium,
  );

  static const TextStyle font15whiteRegular = TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeightHelper.bold,
  );

  static const TextStyle font24Bold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeightHelper.bold,
  );
}
