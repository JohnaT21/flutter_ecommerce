import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static var lightTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headline4: TextStyle(
        color: kNavyTextColor,
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: kNavyTextColor,
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
      ),
      headline5: const TextStyle(
        color: kNavyTextColor,
      ),
      headline6: const TextStyle(
        color: kNavyTextColor,
      ),
      bodyText1: const TextStyle(
        color: kNavyTextColor,
      ),
      bodyText2: const TextStyle(
        color: kNavyTextColor,
      ),
    ),
    primaryColor: kPrimaryColor,
    splashColor: kSplashColor,
    scaffoldBackgroundColor: kBaseColor,
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      background: kBaseColor,
      tertiary: kTertiaryColor,
    ),
  );
}
