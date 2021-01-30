import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static const primary_button = Color(0xFF4269F2);
  static const accents_check = Color(0xFF30D6B0);
  static const drawer_item = Color(0xFF34495E);
  static const drawer_subitem = Color(0xFF293542);

  static const primary = [Color(0xFF4269F2), Color(0xFF517394), Color(0xFF9CB3C9), Color(0xFFDEE6ED)];
  static const secondary = [Color(0xFF388CAD), Color(0xFF78B9D3), Color(0xFFC5E1EC), Color(0xFFECFBFF)];
  static const tertiary = [Color(0xFF634736), Color(0xFF946A51), Color(0xFFC9AD9C), Color(0xFFEDE4DE)];
  static const accents = [Color(0xFFFE8668), Color(0xFFFDBC1F), Color(0xFF30D6B0), Color(0xFF4269F2)];
  static const user_interface = [
    Color(0xFF272D33),
    Color(0xFF6F7276),
    Color(0xFFA3A5A8),
    Color(0xFFC7CCD1),
    Color(0xFFEFEFEF),
    Color(0xFFF9FBFC)
  ];
  static const background = [Color(0xFFFFFFFF), Color(0xFFF9FBFC)];

  static ThemeData lightThemeData = ThemeData(
    textTheme: textTheme,
    brightness: Brightness.light,
    primaryColor: primary.first,
    accentColor: accents[3],
    secondaryHeaderColor: secondary.first,

    // primarySwatch: primary.first,
    // text: primary.first,
  );

  static ThemeData darkThemeData = ThemeData(
    textTheme: textTheme,
    brightness: Brightness.dark,
    accentColor: Colors.amber,
    // primarySwatch: Colors.red,
  );

  static TextTheme textTheme = TextTheme(
    headline1: GoogleFonts.lato(fontSize: 101, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.lato(fontSize: 63, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.lato(fontSize: 50, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.lato(fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.lato(fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.lato(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.lato(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    caption: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.lato(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    button: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25, color: Colors.white),
  );
}
