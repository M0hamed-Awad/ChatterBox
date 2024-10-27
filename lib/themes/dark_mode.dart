import 'package:chatter_box_app/constants.dart';
import 'package:flutter/material.dart';

ThemeData darkModeTheme = ThemeData(
  fontFamily: "Dubai",
  primarySwatch: kPrimarySwatch,
  scaffoldBackgroundColor: kDarkBackgroundColor,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: kPrimaryColor,
    onPrimary: Colors.white,
    surface: kDarkBackgroundColor,
    onSurface: Colors.white,
    secondary: kSecondaryColor,
    onSecondary: Colors.white,
    tertiary: kTertiaryColor,
    onTertiary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    shadowColor: kDarkBackgroundColor,
    elevation: 5,
    centerTitle: true,
    toolbarHeight: 80,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
  ),
);

ThemeData lightModeTheme = ThemeData(
  fontFamily: "Dubai",
  primarySwatch: kPrimarySwatch,
  scaffoldBackgroundColor: kDarkBackgroundColor,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: kPrimaryColor,
    onPrimary: Colors.white,
    surface: kDarkBackgroundColor,
    onSurface: Colors.white,
    secondary: kSecondaryColor,
    onSecondary: Colors.white,
    tertiary: kTertiaryColor,
    onTertiary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    shadowColor: kDarkBackgroundColor,
    elevation: 5,
    centerTitle: true,
    toolbarHeight: 80,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
  ),
);
