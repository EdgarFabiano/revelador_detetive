
import 'package:flutter/material.dart';

class DefaultThemes {

  static final Color primaryLight = Colors.yellow;
  static final Color primaryDark = Colors.black87;

  static ThemeData appTheme() {
    return ThemeData(
        primaryColor: primaryLight, brightness: Brightness.light,
        // colorScheme: ColorScheme.fromSwatch(
        //     primarySwatch: Colors.teal, brightness: Brightness.light, backgroundColor: Colors.white),
        useMaterial3: true);
  }

  static ThemeData darkTheme() {
    return ThemeData(
        primaryColor: primaryDark, brightness: Brightness.dark,
        // colorScheme: ColorScheme.fromSwatch(
        //     primarySwatch: Colors.teal, brightness: Brightness.dark),
        useMaterial3: true);
  }

}