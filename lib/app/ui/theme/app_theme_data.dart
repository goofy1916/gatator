import 'package:flutter/material.dart';
import 'package:gatator/app/ui/theme/color_constants.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: const Color(0xff43566e),
  scaffoldBackgroundColor: const Color(0xff313750),
  appBarTheme: const AppBarTheme(
    color: kPrimaryColor,
    toolbarHeight: 80,
    elevation: 4,
    centerTitle: true,
  ),
  fontFamily: 'Helvetica',
  textTheme: const TextTheme(
    bodyText2: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white),
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
