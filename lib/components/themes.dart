import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData kDarkThemeData = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xff15293a),
  accentColorBrightness: Brightness.dark,
  primaryColor: AppColor.darkThemeColor,
  backgroundColor: AppColor.darkThemeColor,
  accentIconTheme: IconThemeData(
    color: AppColor.primary,
  ),
  accentColor: AppColor.primary,
  appBarTheme: AppBarTheme(
    color: Color(0xff15293a),
    brightness: Brightness.dark,
    iconTheme: IconThemeData(
      color: AppColor.background,
    ),
  ),
  iconTheme: IconThemeData(
    color: AppColor.background,
  ),
  fontFamily: "Montserrat",
);

final ThemeData kLightThemeData = ThemeData(
  canvasColor: AppColor.background,
  accentColor: AppColor.primary,
  errorColor: AppColor.error,
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  iconTheme: IconThemeData(
    color: AppColor.primary,
  ),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: AppColor.primary,
    ),
  ),
  fontFamily: "Roboto", textSelectionTheme: TextSelectionThemeData(cursorColor: AppColor.primary),
);

