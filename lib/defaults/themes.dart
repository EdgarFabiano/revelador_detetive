
import 'package:flutter/material.dart';

class DefaultThemes {

  static final Color primaryLight = Colors.yellow;
  static final Color primaryDark = Colors.black87;

  static ThemeData appTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryLight,
//      secondaryHeaderColor: Colors.yellow,
//      accentColor: Colors.red,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryDark,
    );
  }

}