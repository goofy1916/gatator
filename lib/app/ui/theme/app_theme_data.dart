import 'package:flutter/material.dart';
import 'package:gatator/app/ui/theme/color_constants.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: const Color(0xff43566e),
  scaffoldBackgroundColor: const Color(0xff313750),
  appBarTheme: const AppBarTheme(color: kPrimaryColor),
  fontFamily: 'Helvetica',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline4:
        TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: kTextColor),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xffD9DBDF),
    height: 60,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);
